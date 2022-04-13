import SwiftUI
import shared

struct ContentView: View {

//    @ObservedObject private var userVM = UserViewModel()
    @ObservedObject private var asyncVM = MockAsyncViewModel()
    
//    let viewModel = PickerViewModel()
//    let asyncVM = MockBandViewModel()
    
	var body: some View {
       
        /*
        ObservingView(publisher: asPublisher(viewModel.xOffset)) { output in
            GeometryReader { geometry in
                
                VStack {
                    Rectangle()
                        .frame(width: 100, height: 100, alignment: .center)
                        .foregroundColor(Color.red)
                        .position(x: (geometry.size.width * 0.5) + CGFloat(output.floatValue), y: 100)
                        .animation(.default, value: output.floatValue)
                
                    LeftRightControls(viewModel: viewModel)
                    Text(String(format: "%0.0f", output.floatValue))
                }
            }
        }*/
        
        
        ListView(asyncVM: asyncVM)
            .onAppear {
                asyncVM.load()
            }
    }
}

struct ListView: View {

    @ObservedObject var asyncVM: MockAsyncViewModel

    var body: some View {
        List(asyncVM.band.members, id: \.name) { member in
            Text(member.name)
        }
    }
}

struct UsernameBindingView: View {
    
    @ObservedObject var userVM: UserViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter your name", text: $userVM.username)
            Text("Your username is: \(userVM.username)")
        }
    }
}

struct LeftRightControls: View {
    
    var viewModel: PickerViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button("Left") {
                    viewModel.decrement()
                }
                .buttonStyle(.bordered)
                
                Button("Right") {
                    viewModel.increment()
                }
                .buttonStyle(.bordered)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
