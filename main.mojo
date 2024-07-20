from Vector import InlinedFixedVector

struct TodoList[size: Int]:
    var tasks: InlinedFixedVector[size, StringLiteral]

    fn __init(inout self, capacity: Int):
        self.tasks.__int(capacity)

    fn addTask(inout self, description: StringLiteral, isCompleted: Bool = False):
        if isCompleted:
            print("Completed Task: ", description)
        else:
            self.tasks.append(description)
            print("Added Task: ", description)

    fn completeTask(inout self, description: StringLiteral):
        let tasksLength = self.tasks.__len__()
        var tempPT: InlinedFixedVector[size, StringLiteral] = InlinedFixedVector[size, StringLiteral] (taskLength)
        
        for x in range(0, tasksLength):
            let task = self.tasks.__getitem__(x)
            if task != description:
                temPT.append(task)
            else:
                print("Completed Task: ", task)

        self.tasls.clear()
        self.tasks = temPT

    fn displayTasks(inout self):
        let tasksLength = self.tasks.__len__()

        if tasksLength >0:
            print("\nDisplaying Task")

            for x in range(0, tasksLength):
                let task = self.tasks.__getitem__(x)
                print(x + 1 "-", "Task: ", task)

let todoList = TodoList[10](20)

