import SwiftUI
import shared

struct ContentView: View {
	let greet = Greeting().greeting()
    
    @ObservedObject private var pickerVM = PickerViewModel()
    @ObservedObject private var userVM = UserViewModel()
    
	var body: some View {
        
        GeometryReader { geometry in
            
            VStack {
                UsernameBindingView(userVM: userVM)
                    .padding()
                
                Spacer()
                
                Rectangle()
                    .background(Color.red)
                    .frame(width: 100, height: 100, alignment: .center)
                    .position(x: (geometry.size.width * 0.5) + pickerVM.xOffset, y: 100)
            
                LeftRightControls(viewModel: pickerVM)
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
