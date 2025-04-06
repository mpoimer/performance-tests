package at.poimer.performanceandroid.feature

import android.content.Context
import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import at.poimer.performanceandroid.model.TestModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch
import kotlinx.serialization.json.Json
import java.io.InputStreamReader

data class UIState(
    val models: ArrayList<TestModel> = ArrayList(),
    val isLoading: Boolean = false
)

class TestFeature(
    private val context: Context
) : ViewModel() {
    private val _uiState = MutableStateFlow(UIState())
    val uiState = _uiState.asStateFlow()

    init {
        initialLoad()
    }

    private fun initialLoad() {
        viewModelScope.launch(Dispatchers.IO) {
            setIsLoading(true)
            delay(2000)
            try {
                val jsonString = loadJsonFromAssets()
                val decoded = Json.decodeFromString<List<TestModel>>(jsonString)
                updateModels(models = ArrayList(decoded))
            } catch(exception: Exception) {
                Log.e("mytag", exception.toString())
            }

            setIsLoading(false)
        }
    }

    private fun loadJsonFromAssets(): String {
        val assetManager = context.assets
        assetManager.list("/")
        val inputStream = assetManager.open("test.json")
        val reader = InputStreamReader(inputStream)
        return reader.readText()
    }

    private fun updateModels(models: ArrayList<TestModel>) {
        _uiState.update { currentState ->
            currentState.copy(models = models)
        }
    }

    private fun setIsLoading(isLoading: Boolean) {
        _uiState.update { currentState ->
            currentState.copy(isLoading = isLoading)
        }
    }
}

class TestFeatureFactory(
    private val context: Context
) : ViewModelProvider.Factory {

    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        if (modelClass.isAssignableFrom(TestFeature::class.java)) {
            @Suppress("UNCHECKED_CAST")
            return TestFeature(context) as T
        }
        throw IllegalArgumentException("Unknown ViewModel class")
    }
}