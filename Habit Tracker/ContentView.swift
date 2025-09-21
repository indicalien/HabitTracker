//
//  ContentView.swift
//  Habit Tracker
//
//  Created by Edwin Aviles on 9/17/25.
//


import SwiftUI

struct Habit: Identifiable, Codable
{
    var Entry: String
    var id = UUID()
    var date: Date
    
}

struct ContentView: View {
    
    //variables needed for func's
    
    @State private var habits: [Habit] = []
    @State private var newText = ""
    
    var body: some View {
        HStack {
            
            Text("Habits").bold().frame(maxWidth: .infinity, alignment: .leading)
            Text("Date Added").bold().frame(maxWidth: .infinity, alignment: .leading)
        }
       
        .padding(.horizontal)
        .padding(.vertical)
        Divider()
        
        List(habits) { habit in
            HStack {
                Text(habit.Entry)
                Text(dateFormatter.string(from: habit.date))
            }
        }
        Divider()
        
        HStack {
            TextField("New Entry", text: $newText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            //buttons:
            Button("Add"){
                addHabit()
            }
            .background(Color.blue)
            .foregroundColor(Color.black)
            
            Button("Load"){
                loadHabits()
            }
            .background(Color.yellow)
            .foregroundColor(Color.black)
            
            Button("Save"){
                saveHabits()
            }
            .background(Color.green)
            .foregroundColor(Color.black)
        }
        .padding()
    }
        // functions
        func addHabit(){
            let new_Habit = Habit(Entry: newText, date: Date())
            habits.append(new_Habit)
                    newText = ""
        }
        
        func loadHabits(){
            if let data = UserDefaults.standard.data(forKey: "habits"),
                     let savedHabits = try? JSONDecoder().decode([Habit].self, from: data) {
                      habits = savedHabits
                  }
        }
        
        func saveHabits(){
            if let data = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(data, forKey: "habits")
            }
        }
        
        
        var dateFormatter: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d yyyy HH:mm:ss"
            return formatter
        }
    }

    
    
    
struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
}

