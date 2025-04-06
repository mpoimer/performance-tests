package at.poimer.performanceandroid

import android.util.Log
import androidx.compose.ui.test.ExperimentalTestApi
import androidx.compose.ui.test.hasText
import androidx.compose.ui.test.junit4.createAndroidComposeRule
import androidx.test.core.app.ActivityScenario
import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.platform.app.InstrumentationRegistry
import org.junit.Assert.assertEquals
import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith
import kotlin.system.measureTimeMillis
import kotlin.time.Duration
import kotlin.time.measureTime

/**
 * Instrumented test, which will execute on an Android device.
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
@RunWith(AndroidJUnit4::class)
class ExampleInstrumentedTest {
    @get:Rule
    val composeTestRule = createAndroidComposeRule<MainActivity>()

    @Test
    fun useAppContext() {
        // Context of the app under test.
        val appContext = InstrumentationRegistry.getInstrumentation().targetContext
        assertEquals("at.poimer.performanceandroid", appContext.packageName)
    }

    @OptIn(ExperimentalTestApi::class)
    @Test
    fun testLaunchActivity() {
        val results = mutableListOf<Duration>()

        repeat(10) { i ->
            val time = measureTime {
                val scenario = ActivityScenario.launch(MainActivity::class.java)

                composeTestRule.waitUntilExactlyOneExists(
                    hasText("this is a test"),
                    timeoutMillis = 3000
                )

                scenario.close()
            }

            results.add(time)
        }


        val average = results.map { it.inWholeMilliseconds }.average()
        Log.d("LaunchTiming", "Average time over ${results.size} runs: $average ms")
    }
}