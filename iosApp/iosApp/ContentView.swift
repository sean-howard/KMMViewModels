import SwiftUI
import shared

struct ContentView: View {
	let greet = Greeting().greeting()
    
    @ObservedObject private var pickerVM = PickerViewModel()
    @ObservedObject private var userVM = UserViewModel()
    @ObservedObject private var asyncVM = MockAsyncViewModel()
    
	var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                
                List(asyncVM.band.members, id: \.name) { member in
                    Text(member.name)
                }
                                
                UsernameBindingView(userVM: userVM)
                    .padding()
                
                Spacer()
                
                Rectangle()
                    .frame(width: 100, height: 100, alignment: .center)
                    .foregroundColor(Color.red)
                    .position(x: (geometry.size.width * 0.5) + pickerVM.xOffset, y: 100)
            
                LeftRightControls(viewModel: pickerVM)
            }
            .onAppear {
                asyncVM.load()
            }
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
    
    @ObservedObject var viewModel: PickerViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button("Left") {
                    withAnimation {
                        viewModel.decrement()
                    }
                    
                }
                .buttonStyle(.bordered)
                
                Button("Right") {
                    withAnimation {
                        viewModel.increment()
                    }
                }
                .buttonStyle(.bordered)
            }
            
            Text(String(format: "%.0f", viewModel.xOffset))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
