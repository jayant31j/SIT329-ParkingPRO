import tkinter as tk
import random

class ParkingProApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Parking Pro System")
        
        self.num_spaces = 20
        self.parking_spaces = [True] * self.num_spaces  
        self.fill_time_estimates = [random.randint(5, 30) for _ in range(self.num_spaces)]
        
        self.create_gui()
        self.update_display()
        
    def create_gui(self):
        self.title_label = tk.Label(root, text="Parking Pro System", font=("Helvetica", 16, "bold"))
        self.title_label.pack(pady=10)
        
        self.space_frame = tk.Frame(root)
        self.space_frame.pack()
        
        self.space_labels = []
        self.fill_time_labels = []
        
        for i in range(self.num_spaces):
            space_label = tk.Label(self.space_frame, text=f"Space {i+1}", width=10)
            fill_time_label = tk.Label(self.space_frame, text="Est. Time: ", width=10)
            self.space_labels.append(space_label)
            self.fill_time_labels.append(fill_time_label)
        
        for i in range(self.num_spaces):
            self.space_labels[i].grid(row=i, column=0, padx=5, pady=5)
            self.fill_time_labels[i].grid(row=i, column=1, padx=5, pady=5)
        
        self.update_button = tk.Button(root, text="Update", command=self.update_parking_status)
        self.update_button.pack(pady=10)

        self.total_empty_label = tk.Label(root, text="Total Empty Spaces:")
        self.total_empty_label.pack()
        
        self.total_filled_label = tk.Label(root, text="Total Filled Spaces:")
        self.total_filled_label.pack()
        
    def update_parking_status(self):
        for i in range(self.num_spaces):
            self.parking_spaces[i] = random.choice([True, False])
            self.fill_time_estimates[i] = random.randint(5, 30)
        
        self.update_display()
        
    def update_display(self):
        empty_spaces = [i for i, space in enumerate(self.parking_spaces) if space]
        filled_spaces = [i for i, space in enumerate(self.parking_spaces) if not space]

        self.total_empty_label.config(text=f"Total Empty Spaces: {len(empty_spaces)}")
        self.total_filled_label.config(text=f"Total Filled Spaces: {len(filled_spaces)}")
        
        for i in range(self.num_spaces):
            if i in empty_spaces:
                self.space_labels[i].config(bg="green", text=f"Space {i+1} (Empty)")
                self.fill_time_labels[i].config(text=f"Est. Time: N/A")
            else:
                self.space_labels[i].config(bg="red", text=f"Space {i+1} (Filled)")
                self.fill_time_labels[i].config(text=f"Est. Time: {self.fill_time_estimates[i]} mins")
        
        self.root.update_idletasks()
        
root = tk.Tk()
app = ParkingProApp(root)
root.mainloop()
