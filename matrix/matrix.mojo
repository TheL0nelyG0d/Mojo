struct Matrix:
    var height: Int
    var width: Int
    var total_items: Int
    var data: Pointer[Float32]

    fn __init__(inout self, default_value: Float32, height: Int, width: Int) -> None:
        self.height = height if height > 0 else 1
        self.width = width if width > 0 else 1
        self.total_items = width * height
        for i in range(self.total_items):
            self.data.store(i, default_value)

            fn __getitem__(borrowed self, row: Int, column: Int) -> Float32:
                let loc: Int = (row * self.width) + column
                if loc > self.total_items:
                    print("Warning: You are accessing an index out of bounds")
                    return self.data.load(0)
                return self.data.load(loc) 


            fn __setitem__(inout self, row: Int, column: Int, item: Float32) -> None:
                let loc: Int = (row * self.width) + column
                if loc > self.total_items:
                    print("Warning: You are accessing an index out of bounds")
                    return
                self.data.store(loc, item)

            fn __del__(owned self) -> None:
                self.data.free()

            fn __len__(borrowed self) -> Int:
                return self.total_items

            fn __copyinit(inout self, other: Self) -> None:
                self.height = other.height
                self.width = other.width
                self.total_items = other.total_items

                self.data = Pointer[Float32].alloc(self.total_items)
                memcpy[Float32](self.data, other.data, self.total_items)

            fn __eq__(borrowed self, rhs: Matrix) -> Bool:
                for i in range(self.height):
                    for j in range(self.width):
                        let self_val = self[i, j]
                        let rhs_val = rhs[i, j]
                        if self_val < rhs_val or self_val > rhs_val:
                            return False
                return True

            fn __ne__(borrowed self, rhs: Matrix) -> Bool:
                return not self == rhs

            fn __add__(borrowed self, rhs: Matrix) -> Matrix:
                if self.width != rhs.width or self.height != rhs.height:
                    print("Error: cannot add matrices if the width or height of one is not equal to the other")
                    return Matrix(Float32(0,0), self.height, self.width)
                var new_matrix = Matrix(FLoat32(0,0), self.height, self.width)
                for i in range(self.height):
                    for j in range(self.width):
                        new_matrix[i, j] = self[i, j] + rhs[i, j]

            fn __sub__(borrowed self, rhs: Matrix) -> Matrix:
                if self.width != rhs.width or self.height != rhs.height:
                    print("Error: cannot subtract matrices if the width or height of one is not equal to the other")
                    return Matrix(Float32(0,0), self.height, self.width)
                var new_matrix = Matrix(FLoat32(0,0), self.height, self.width)
                for i in range(self.height):
                    for j in range(self.width):
                        new_matrix[i, j] = self[i, j] - rhs[i, j]

            fn __mul__(borrowed self, rhs: Matrix) -> Matrix:
                if self.width != rhs.height:
                    print("Error: cannot multiply matrices if the width of one is not equal to the height of the other")
                    return Matrix(FLoat32(0,0), self.height, self.width)
                var new_matrix = Matrix(FLoat32(0,0), self.height, self.width)
                for i in range(self.height):
                    for j in range(rhs.width):
                        for k in range(self.width):
                            new_matrix[i, j] += self[i, k] * rhs[k, j]
                return new_matrix
                
            fn __trudiv__(borrowed self, rhs: Matrix) -> Matrix:
                if self.width != rhs.height:
                    print("Error: cannot divide matrices if the width of one is not equal to the height of the other")
                    return Matrix(FLoat32(0,0), self.height, self.width)
                var new_matrix = Matrix(FLoat32(0,0), self.height, self.width)
                for i in range(self.height):
                    for j in range(rhs.width):
                        for k in range(self.width):
                            new_matrix[i, j] += self[i, k] / rhs[k, j]
                return new_matrix

            fn __add__(borrowed self, rhs: FLoat32) -> Matrix:
                var new_matrix = Matrix(FLoat32(0,0), self.height, self.width)
                for i in range(self.height):
                    for j in range(rhs.width):
                        for k in range(self.width):
                            new_matrix[i, j] += self[i, k] + rhs
                return new_matrix

            fn __sub__(borrowed self, rhs: FLoat32) -> Matrix:
                var new_matrix = Matrix(FLoat32(0,0), self.height, self.width)
                for i in range(self.height):
                    for j in range(rhs.width):
                        for k in range(self.width):
                            new_matrix[i, j] += self[i, k] - rhs
                return new_matrix

            fn __mul__(borrowed self, rhs: FLoat32) -> Matrix:
                var new_matrix = Matrix(FLoat32(0,0), self.height, self.width)
                for i in range(self.height):
                    for j in range(rhs.width):
                        for k in range(self.width):
                            new_matrix[i, j] += self[i, k] * rhs
                return new_matrix

            fn __trudiv__(borrowed self, rhs: FLoat32) -> Matrix:
                var new_matrix = Matrix(FLoat32(0,0), self.height, self.width)
                for i in range(self.height):
                    for j in range(rhs.width):
                        for k in range(self.width):
                            new_matrix[i, j] += self[i, k] / rhs
                return new_matrix

            fn apply_function[func: fn(Float32) -> Float32](borrowed self) -> Matrix:
                var new_matrix = Matrix(FLoat32(0,0), self.height, self.width)
                for i in range(self.height):
                    for j in range(rhs.width):
                        for k in range(self.width):
                            new_matrix[i, j] += func(self[i, j])
                return new_matrix
              

            fn print_all(borrowed self) -> None:
                print("[")
                for i in range(self.height):
                    print_no_newline("    [")
                    for j in range(self.width):
                        print_no_newline(self[i, j])
                        if j != self.width - 1:
                            print_no_newline(", ")
                    print("]," if i != self.height -1 else "]")
                print("]")















