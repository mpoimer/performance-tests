package at.poimer.performanceandroid

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.CircularProgressIndicator
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.HorizontalDivider
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.lifecycle.ViewModelProvider
import at.poimer.performanceandroid.feature.TestFeature
import at.poimer.performanceandroid.feature.TestFeatureFactory
import at.poimer.performanceandroid.ui.theme.PerformanceAndroidTheme

class MainActivity : ComponentActivity() {
    private lateinit var viewModel: TestFeature


    @OptIn(ExperimentalMaterial3Api::class)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        viewModel = ViewModelProvider(
            this,
            TestFeatureFactory(
                this
            )
        )[TestFeature::class.java]

        enableEdgeToEdge()
        setContent {
            PerformanceAndroidTheme {
                Scaffold(
                    modifier = Modifier.fillMaxSize(),
                    topBar = { TopAppBar(title = { TopAppBarTitle(viewModel = viewModel) }) }
                ) { innerPadding ->
                    TestList(viewModel = viewModel, innerPadding = innerPadding)
                }
            }
        }
    }
}

@Composable
fun TopAppBarTitle(viewModel: TestFeature) {
    val uiModel = viewModel.uiState.collectAsState()

    Text("Items ${uiModel.value.models.size}")
}

@Composable
fun TestList(viewModel: TestFeature, innerPadding: PaddingValues) {
    val uiModel = viewModel.uiState.collectAsState()

    if (uiModel.value.isLoading) {
        Column(
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.Center,
            modifier = Modifier.fillMaxSize()
        ) {
            CircularProgressIndicator()
        }

    } else {
        LazyColumn(modifier = Modifier.padding(innerPadding)) {
            item {
                Text("this is a test")
            }
            items(uiModel.value.models) { item ->
                Column(modifier = Modifier.padding(8.dp)) {
                    Text(item.name, style = TextStyle.Default.copy(fontWeight = FontWeight.Bold))
                    Text(item.bio)
                }
                HorizontalDivider()
            }
        }
    }
}