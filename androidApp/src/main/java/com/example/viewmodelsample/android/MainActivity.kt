package com.example.viewmodelsample.android

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.TextView
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material.*
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.example.viewmodelsample.Band
import com.example.viewmodelsample.MockBandViewModel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.collect
import kotlin.coroutines.CoroutineContext

class MainActivity : AppCompatActivity(), CoroutineScope {

    override val coroutineContext: CoroutineContext = Dispatchers.Main

    val asyncVM = MockBandViewModel()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            MainLayout(asyncVM)
        }
    }
}

@Composable
fun MainLayout(viewModel: MockBandViewModel) {
    
    val band by viewModel.bandFlow.collectAsState()
    
    MaterialTheme() {
        Scaffold(topBar = {
            TopAppBar(modifier = Modifier.fillMaxWidth()) {
                Row(Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.Center) {
                    Text(text = "Band")
                }
            }
        }) {
            Column(
                modifier = Modifier.fillMaxSize(),
                verticalArrangement = Arrangement.Top,
                horizontalAlignment = Alignment.CenterHorizontally
            ) {


                LazyColumn(Modifier.fillMaxHeight()) {
                    items(band.members) {
                        Card(
                            Modifier
                                .fillMaxWidth()
                                .padding(10.dp), elevation = 10.dp
                        ) {
                            Column(Modifier.padding(15.dp)) {
                                Text(
                                    text = "${it.name}",
                                    style = MaterialTheme.typography.subtitle1
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}