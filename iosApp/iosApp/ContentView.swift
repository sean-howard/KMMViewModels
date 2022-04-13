import SwiftUI
import shared

struct ContentView: View {
    
//    @ObservedObject private var pickerVM = PickerViewModel()
//    @ObservedObject private var userVM = UserViewModel()
//    @ObservedObject private var asyncVM = MockAsyncViewModel()
    
    let viewModel = PickerViewModel()
    
	var body: some View {
        
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
        }
	}
}

struct ListView: View {
    
    var asyncVM: MockAsyncViewModel
    
    var body: some View {
        List(asyncVM.band.members, id: \.name) { member in
            Text(member.name)
        }
        .onAppear {
            asyncVM.load()
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
