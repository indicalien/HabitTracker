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
            
            Table(habits) {
                TableColumn("Habit") { habit in
                    Text(habit.Entry)
                        .font(.title3)
                        .foregroundColor(.green)
                }
                
                TableColumn("Date") { habit in
                    Text(dateFormatter.string(from: habit.date))
                        .font(.title3)
                        .foregroundColor(.green)
                        
                }
                
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
            .cornerRadius(10)
            
            Button("Load"){
                loadHabits()
            }
            .background(Color.yellow)
            .foregroundColor(Color.black)
            .cornerRadius(10)
            Button("Save"){
                saveHabits()
            }
            .background(Color.green)
            .foregroundColor(Color.black)
            .cornerRadius(10)
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

