$sudoku_list = [5,3,0, 0,7,0, 0,0,0,
				6,0,0, 1,9,5, 0,0,0,
				0,9,8, 0,0,0, 0,6,7,
				8,0,0, 0,6,0, 0,0,3,
				4,0,0, 8,0,3, 0,0,1,
				7,0,0, 0,2,0, 0,0,6,
				0,6,0, 0,0,0, 2,8,0,
				0,0,0, 4,1,9, 0,0,5,
				0,0,0, 0,8,6, 0,7,9]

def print_sudoku(sudoku)
	r = 0
	while r <81
		sudoku_row = ""
		for c in (0..8)
			sudoku_row += sudoku[r+c].to_s
		end
		puts "#{sudoku_row}"
		r+=9
		sudoku_row = ""
	end
	puts ""
end

def all_different(list)
	len = list.length
	for i in (0..len-1)
		for k in (0..i-1)
			if list[i] == list[k] && list[i] != 0
				return false
			end
		end
	end
	return true
end

def get_col(sudoku, col_num)
	sudoku_col = []
	i = 0
	c = col_num
	while c < 81
		sudoku_col[i] = sudoku[c]
		c+=9
		i+=1
	end
	return sudoku_col
end

def get_row(sudoku, row_num)
	sudoku_row = []
	i = 0
	r = row_num*9
	while i < 9
		sudoku_row[i] = sudoku[r+i]
		i+=1
	end
	return sudoku_row
end

def get_box(sudoku, box_num)
	sudoku_box = []
	i = 0
	if box_num == 1
		i = 3
	elsif box_num == 2
		i = 6
	elsif box_num == 3
		i = 27
	elsif box_num == 4
		i = 30
	elsif box_num == 5
		i = 33
	elsif box_num == 6
		i = 54
	elsif box_num == 7
		i = 57
	elsif box_num == 8
		i = 60
	end
	index = 0
	c = 0
	r = 0
	while r < 3
		while c < 3
			sudoku_box[index] = sudoku[i+c+r*9]
			index += 1
			c += 1 
		end 
		r += 1
		c = 0
	end
	return sudoku_box		
end

def copy(sudoku)
	sudoku_copy = []
	for i in (0..80)
		sudoku_copy[i] = sudoku[i]
	end
	return sudoku_copy
end

def completed(sudoku)
	for i in (0..80)
		if sudoku[i] == 0
			return false
		end
	end
	return true
end

def legal(sudoku)
	for i in (0..8)
		if !all_different(get_col(sudoku,i)) ||
			!all_different(get_row(sudoku,i)) ||
			!all_different(get_box(sudoku,i))
				return false
		end
	end
	return true
end

def add(sudoku,val)
	i = 0
	while sudoku[i] != 0
		i+=1
	end
	sudoku[i] = val
end

def dfs(sudoku)
	if completed(sudoku)
		return sudoku
	end
	for i in 1..9
		sudoku_copy = copy(sudoku)
		add(sudoku_copy,i)
		if legal(sudoku_copy)
			s = dfs(sudoku_copy)
			if s != nil
				return s
			end
		end
	end
	return nil
end

def pe(sudokus)
	total = 0
	for i in 0..49
		solved = dfs(sudokus[i])
		print_sudoku(solved)
		total += 100*solved[0]+10*solved[1]+solved[2]
	end
	return total
end

$all_sudokus = [[0,0,3,0,2,0,6,0,0,9,0,0,3,0,5,0,0,1,0,0,1,8,0,6,4,0,0,0,0,8,1,0,2,9,0,0,7,0,0,0,0,0,0,0,8,0,0,6,7,0,8,2,0,0,0,0,2,6,0,9,5,0,0,8,0,0,2,0,3,0,0,9,0,0,5,0,1,0,3,0,0],
				[2,0,0,0,8,0,3,0,0,0,6,0,0,7,0,0,8,4,0,3,0,5,0,0,2,0,9,0,0,0,1,0,5,4,0,8,0,0,0,0,0,0,0,0,0,4,0,2,7,0,6,0,0,0,3,0,1,0,0,7,0,4,0,7,2,0,0,4,0,0,6,0,0,0,4,0,1,0,0,0,3],
				[0,0,0,0,0,0,9,0,7,0,0,0,4,2,0,1,8,0,0,0,0,7,0,5,0,2,6,1,0,0,9,0,4,0,0,0,0,5,0,0,0,0,0,4,0,0,0,0,5,0,7,0,0,9,9,2,0,1,0,8,0,0,0,0,3,4,0,5,9,0,0,0,5,0,7,0,0,0,0,0,0],
				[0,3,0,0,5,0,0,4,0, 0,0,8,0,1,0,5,0,0, 4,6,0,0,0,0,0,1,2, 0,7,0,5,0,2,0,8,0, 0,0,0,6,0,3,0,0,0, 0,4,0,1,0,9,0,3,0, 2,5,0,0,0,0,0,9,8, 0,0,1,0,2,0,6,0,0, 0,8,0,0,6,0,0,2,0], 
				[0,2,0,8,1,0,7,4,0, 7,0,0,0,0,3,1,0,0, 0,9,0,0,0,2,8,0,5, 0,0,9,0,4,0,0,8,7, 4,0,0,2,0,8,0,0,3, 1,6,0,0,3,0,2,0,0, 3,0,2,7,0,0,0,6,0, 0,0,5,6,0,0,0,0,8, 0,7,6,0,5,1,0,9,0] , [1,0,0,9,2,0,0,0,0, 5,2,4,0,1,0,0,0,0, 0,0,0,0,0,0,0,7,0, 0,5,0,0,0,8,1,0,2, 0,0,0,0,0,0,0,0,0, 4,0,2,7,0,0,0,9,0, 0,6,0,0,0,0,0,0,0, 0,0,0,0,3,0,9,4,5, 0,0,0,0,7,1,0,0,6] , [0,4,3,0,8,0,2,5,0, 6,0,0,0,0,0,0,0,0, 0,0,0,0,0,1,0,9,4, 9,0,0,0,0,4,0,7,0, 0,0,0,6,0,8,0,0,0, 0,1,0,2,0,0,0,0,3, 8,2,0,5,0,0,0,0,0, 0,0,0,0,0,0,0,0,5, 0,3,4,0,9,0,7,1,0] , [4,8,0,0,0,6,9,0,2, 0,0,2,0,0,8,0,0,1, 9,0,0,3,7,0,0,6,0, 8,4,0,0,1,0,2,0,0, 0,0,3,7,0,4,1,0,0, 0,0,1,0,6,0,0,4,9, 0,2,0,0,8,5,0,0,7, 7,0,0,9,0,0,6,0,0, 6,0,9,2,0,0,0,1,8] , [0,0,0,9,0,0,0,0,2, 0,5,0,1,2,3,4,0,0, 0,3,0,0,0,0,1,6,0, 9,0,8,0,0,0,0,0,0, 0,7,0,0,0,0,0,9,0, 0,0,0,0,0,0,2,0,5, 0,9,1,0,0,0,0,5,0, 0,0,7,4,3,9,0,2,0, 4,0,0,0,0,7,0,0,0] , [0,0,1,9,0,0,0,0,3, 9,0,0,7,0,0,1,6,0, 0,3,0,0,0,5,0,0,7, 0,5,0,0,0,0,0,0,9, 0,0,4,3,0,2,6,0,0, 2,0,0,0,0,0,0,7,0, 6,0,0,1,0,0,0,3,0, 0,4,2,0,0,7,0,0,6, 5,0,0,0,0,6,8,0,0] , [0,0,0,1,2,5,4,0,0, 0,0,8,4,0,0,0,0,0, 4,2,0,8,0,0,0,0,0, 0,3,0,0,0,0,0,9,5, 0,6,0,9,0,2,0,1,0, 5,1,0,0,0,0,0,6,0, 0,0,0,0,0,3,0,4,9, 0,0,0,0,0,7,2,0,0, 0,0,1,2,9,8,0,0,0] , [0,6,2,3,4,0,7,5,0, 1,0,0,0,0,5,6,0,0, 5,7,0,0,0,0,0,4,0, 0,0,0,0,9,4,8,0,0, 4,0,0,0,0,0,0,0,6, 0,0,5,8,3,0,0,0,0, 0,3,0,0,0,0,0,9,1, 0,0,6,4,0,0,0,0,7, 0,5,9,0,8,3,2,6,0] , [3,0,0,0,0,0,0,0,0, 0,0,5,0,0,9,0,0,0, 2,0,0,5,0,4,0,0,0, 0,2,0,0,0,0,7,0,0, 1,6,0,0,0,0,0,5,8, 7,0,4,3,1,0,6,0,0, 0,0,0,8,9,0,1,0,0, 0,0,0,0,6,7,0,8,0, 0,0,0,0,0,5,4,3,7] , [6,3,0,0,0,0,0,0,0, 0,0,0,5,0,0,0,0,8, 0,0,5,6,7,4,0,0,0, 0,0,0,0,2,0,0,0,0, 0,0,3,4,0,1,0,2,0, 0,0,0,0,0,0,3,4,5, 0,0,0,0,0,7,0,0,4, 0,8,0,3,0,0,9,0,2, 9,4,7,1,0,0,0,8,0] , [0,0,0,0,2,0,0,4,0, 0,0,8,0,3,5,0,0,0, 0,0,0,0,7,0,6,0,2, 0,3,1,0,4,6,9,7,0, 2,0,0,0,0,0,0,0,0, 0,0,0,5,0,1,2,0,3, 0,4,9,0,0,0,7,3,0, 0,0,0,0,0,0,0,1,0, 8,0,0,0,0,4,0,0,0] , [3,6,1,0,2,5,9,0,0, 0,8,0,9,6,0,0,1,0, 4,0,0,0,0,0,0,5,7, 0,0,8,0,0,0,4,7,1, 0,0,0,6,0,3,0,0,0, 2,5,9,0,0,0,8,0,0, 7,4,0,0,0,0,0,0,5, 0,2,0,0,1,8,0,6,0, 0,0,5,4,7,0,3,2,9] , [0,5,0,8,0,7,0,2,0, 6,0,0,0,1,0,0,9,0, 7,0,2,5,4,0,0,0,6, 0,7,0,0,2,0,3,0,1, 5,0,4,0,0,0,9,0,8, 1,0,3,0,8,0,0,7,0, 9,0,0,0,7,6,2,0,5, 0,6,0,0,9,0,0,0,3, 0,8,0,1,0,3,0,4,0] , [0,8,0,0,0,5,0,0,0, 0,0,0,0,0,3,4,5,7, 0,0,0,0,7,0,8,0,9, 0,6,0,4,0,0,9,0,3, 0,0,7,0,1,0,5,0,0, 4,0,8,0,0,7,0,2,0, 9,0,1,0,2,0,0,0,0, 8,4,2,3,0,0,0,0,0, 0,0,0,1,0,0,0,8,0] , [0,0,3,5,0,2,9,0,0, 0,0,0,0,4,0,0,0,0, 1,0,6,0,0,0,3,0,5, 9,0,0,2,5,1,0,0,8, 0,7,0,4,0,8,0,3,0, 8,0,0,7,6,3,0,0,1, 3,0,8,0,0,0,1,0,4, 0,0,0,0,2,0,0,0,0, 0,0,5,1,0,4,8,0,0] , [0,0,0,0,0,0,0,0,0, 0,0,9,8,0,5,1,0,0, 0,5,1,9,0,7,4,2,0, 2,9,0,4,0,1,0,6,5, 0,0,0,0,0,0,0,0,0, 1,4,0,5,0,8,0,9,3, 0,2,6,7,0,9,5,8,0, 0,0,5,1,0,3,6,0,0, 0,0,0,0,0,0,0,0,0] , [0,2,0,0,3,0,0,9,0, 0,0,0,9,0,7,0,0,0, 9,0,0,2,0,8,0,0,5, 0,0,4,8,0,6,5,0,0, 6,0,7,0,0,0,2,0,8, 0,0,3,1,0,2,9,0,0, 8,0,0,6,0,5,0,0,7, 0,0,0,3,0,9,0,0,0, 0,3,0,0,2,0,0,5,0] , [0,0,5,0,0,0,0,0,6, 0,7,0,0,0,9,0,2,0, 0,0,0,5,0,0,1,0,7, 8,0,4,1,5,0,0,0,0, 0,0,0,8,0,3,0,0,0, 0,0,0,0,9,2,8,0,5, 9,0,7,0,0,6,0,0,0, 0,3,0,4,0,0,0,1,0, 2,0,0,0,0,0,6,0,0] , [0,4,0,0,0,0,0,5,0, 0,0,1,9,4,3,6,0,0, 0,0,9,0,0,0,3,0,0, 6,0,0,0,5,0,0,0,2, 1,0,3,0,0,0,5,0,6, 8,0,0,0,2,0,0,0,7, 0,0,5,0,0,0,2,0,0, 0,0,2,4,3,6,7,0,0, 0,3,0,0,0,0,0,4,0] , [0,0,4,0,0,0,0,0,0, 0,0,0,0,3,0,0,0,2, 3,9,0,7,0,0,0,8,0, 4,0,0,0,0,9,0,0,1, 2,0,9,8,0,1,3,0,7, 6,0,0,2,0,0,0,0,8, 0,1,0,0,0,8,0,5,3, 9,0,0,0,4,0,0,0,0, 0,0,0,0,0,0,8,0,0] , [3,6,0,0,2,0,0,8,9, 0,0,0,3,6,1,0,0,0, 0,0,0,0,0,0,0,0,0, 8,0,3,0,0,0,6,0,2, 4,0,0,6,0,3,0,0,7, 6,0,7,0,0,0,1,0,8, 0,0,0,0,0,0,0,0,0, 0,0,0,4,1,8,0,0,0, 9,7,0,0,3,0,0,1,4] , [5,0,0,4,0,0,0,6,0, 0,0,9,0,0,0,8,0,0, 6,4,0,0,2,0,0,0,0, 0,0,0,0,0,1,0,0,8, 2,0,8,0,0,0,5,0,1, 7,0,0,5,0,0,0,0,0, 0,0,0,0,9,0,0,8,4, 0,0,3,0,0,0,6,0,0, 0,6,0,0,0,3,0,0,2] , [0,0,7,2,5,6,4,0,0, 4,0,0,0,0,0,0,0,5, 0,1,0,0,3,0,0,6,0, 0,0,0,5,0,8,0,0,0, 0,0,8,0,6,0,2,0,0, 0,0,0,1,0,7,0,0,0, 0,3,0,0,7,0,0,9,0, 2,0,0,0,0,0,0,0,4, 0,0,6,3,1,2,7,0,0] , [0,0,0,0,0,0,0,0,0, 0,7,9,0,5,0,1,8,0, 8,0,0,0,0,0,0,0,7, 0,0,7,3,0,6,8,0,0, 4,5,0,7,0,8,0,9,6, 0,0,3,5,0,2,7,0,0, 7,0,0,0,0,0,0,0,5, 0,1,6,0,3,0,4,2,0, 0,0,0,0,0,0,0,0,0] , [0,3,0,0,0,0,0,8,0, 0,0,9,0,0,0,5,0,0, 0,0,7,5,0,9,2,0,0, 7,0,0,1,0,5,0,0,8, 0,2,0,0,9,0,0,3,0, 9,0,0,4,0,2,0,0,1, 0,0,4,2,0,7,1,0,0, 0,0,2,0,0,0,8,0,0, 0,7,0,0,0,0,0,9,0] , [2,0,0,1,7,0,6,0,3, 0,5,0,0,0,0,1,0,0, 0,0,0,0,0,6,0,7,9, 0,0,0,0,4,0,7,0,0, 0,0,0,8,0,1,0,0,0, 0,0,9,0,5,0,0,0,0, 3,1,0,4,0,0,0,0,0, 0,0,5,0,0,0,0,6,0, 9,0,6,0,3,7,0,0,2] , [0,0,0,0,0,0,0,8,0, 8,0,0,7,0,1,0,4,0, 0,4,0,0,2,0,0,3,0, 3,7,4,0,0,0,9,0,0, 0,0,0,0,3,0,0,0,0, 0,0,5,0,0,0,3,2,1, 0,1,0,0,6,0,0,5,0, 0,5,0,8,0,2,0,0,6, 0,8,0,0,0,0,0,0,0] , [0,0,0,0,0,0,0,8,5, 0,0,0,2,1,0,0,0,9, 9,6,0,0,8,0,1,0,0, 5,0,0,8,0,0,0,1,6, 0,0,0,0,0,0,0,0,0, 8,9,0,0,0,6,0,0,7, 0,0,9,0,7,0,0,5,2, 3,0,0,0,5,4,0,0,0, 4,8,0,0,0,0,0,0,0] , [6,0,8,0,7,0,5,0,2, 0,5,0,6,0,8,0,7,0, 0,0,2,0,0,0,3,0,0, 5,0,0,0,9,0,0,0,6, 0,4,0,3,0,2,0,5,0, 8,0,0,0,5,0,0,0,3, 0,0,5,0,0,0,2,0,0, 0,1,0,7,0,4,0,9,0, 4,0,9,0,6,0,7,0,1] , [0,5,0,0,1,0,0,4,0, 1,0,7,0,0,0,6,0,2, 0,0,0,9,0,5,0,0,0, 2,0,8,0,3,0,5,0,1, 0,4,0,0,7,0,0,2,0, 9,0,1,0,8,0,4,0,6, 0,0,0,4,0,1,0,0,0, 3,0,4,0,0,0,7,0,9, 0,2,0,0,6,0,0,1,0] , [0,5,3,0,0,0,7,9,0, 0,0,9,7,5,3,4,0,0, 1,0,0,0,0,0,0,0,2, 0,9,0,0,8,0,0,1,0, 0,0,0,9,0,7,0,0,0, 0,8,0,0,3,0,0,7,0, 5,0,0,0,0,0,0,0,3, 0,0,7,6,4,1,2,0,0, 0,6,1,0,0,0,9,4,0] , [0,0,6,0,8,0,3,0,0, 0,4,9,0,7,0,2,5,0, 0,0,0,4,0,5,0,0,0, 6,0,0,3,1,7,0,0,4, 0,0,7,0,0,0,8,0,0, 1,0,0,8,2,6,0,0,9, 0,0,0,7,0,2,0,0,0, 0,7,5,0,4,0,1,9,0, 0,0,3,0,9,0,6,0,0] , [0,0,5,0,8,0,7,0,0, 7,0,0,2,0,4,0,0,5, 3,2,0,0,0,0,0,8,4, 0,6,0,1,0,5,0,4,0, 0,0,8,0,0,0,5,0,0, 0,7,0,8,0,3,0,1,0, 4,5,0,0,0,0,0,9,1, 6,0,0,5,0,8,0,0,7, 0,0,3,0,1,0,6,0,0] , [0,0,0,9,0,0,8,0,0, 1,2,8,0,0,6,4,0,0, 0,7,0,8,0,0,0,6,0, 8,0,0,4,3,0,0,0,7, 5,0,0,0,0,0,0,0,9, 6,0,0,0,7,9,0,0,8, 0,9,0,0,0,4,0,1,0, 0,0,3,6,0,0,2,8,4, 0,0,1,0,0,7,0,0,0] , [0,0,0,0,8,0,0,0,0, 2,7,0,0,0,0,0,5,4, 0,9,5,0,0,0,8,1,0, 0,0,9,8,0,6,4,0,0, 0,2,0,4,0,3,0,6,0, 0,0,6,9,0,5,1,0,0, 0,1,7,0,0,0,6,2,0, 4,6,0,0,0,0,0,3,8, 0,0,0,0,9,0,0,0,0] , [0,0,0,6,0,2,0,0,0, 4,0,0,0,5,0,0,0,1, 0,8,5,0,1,0,6,2,0, 0,3,8,2,0,6,7,1,0, 0,0,0,0,0,0,0,0,0, 0,1,9,4,0,7,3,5,0, 0,2,6,0,4,0,5,3,0, 9,0,0,0,2,0,0,0,7, 0,0,0,8,0,9,0,0,0] , [0,0,0,9,0,0,0,0,2, 0,5,0,1,2,3,4,0,0, 0,3,0,0,0,0,1,6,0, 9,0,8,0,0,0,0,0,0, 0,7,0,0,0,0,0,9,0, 0,0,0,0,0,0,2,0,5, 0,9,1,0,0,0,0,5,0, 0,0,7,4,3,9,0,2,0, 4,0,0,0,0,7,0,0,0] , [3,8,0,0,0,0,0,0,0, 0,0,0,4,0,0,7,8,5, 0,0,9,0,2,0,3,0,0, 0,6,0,0,9,0,0,0,0, 8,0,0,3,0,2,0,0,9, 0,0,0,0,4,0,0,7,0, 0,0,1,0,7,0,5,0,0, 4,9,5,0,0,6,0,0,0, 0,0,0,0,0,0,0,9,2] , [0,0,0,1,5,8,0,0,0, 0,0,2,0,6,0,8,0,0, 0,3,0,0,0,0,0,4,0, 0,2,7,0,3,0,5,1,0, 0,0,0,0,0,0,0,0,0, 0,4,6,0,8,0,7,9,0, 0,5,0,0,0,0,0,8,0, 0,0,4,0,7,0,1,0,0, 0,0,0,3,2,5,0,0,0] , [0,1,0,5,0,0,2,0,0, 9,0,0,0,0,1,0,0,0, 0,0,2,0,0,8,0,3,0, 5,0,0,0,3,0,0,0,7, 0,0,8,0,0,0,5,0,0, 6,0,0,0,8,0,0,0,4, 0,4,0,1,0,0,7,0,0, 0,0,0,7,0,0,0,0,6, 0,0,3,0,0,4,0,5,0] , [0,8,0,0,0,0,0,4,0, 0,0,0,4,6,9,0,0,0, 4,0,0,0,0,0,0,0,7, 0,0,5,9,0,4,6,0,0, 0,7,0,6,0,8,0,3,0, 0,0,8,5,0,2,1,0,0, 9,0,0,0,0,0,0,0,5, 0,0,0,7,8,1,0,0,0, 0,6,0,0,0,0,0,1,0] , [9,0,4,2,0,0,0,0,7, 0,1,0,0,0,0,0,0,0, 0,0,0,7,0,6,5,0,0, 0,0,0,8,0,0,0,9,0, 0,2,0,9,0,4,0,6,0, 0,4,0,0,0,2,0,0,0, 0,0,1,6,0,7,0,0,0, 0,0,0,0,0,0,0,3,0, 3,0,0,0,0,5,7,0,2] , [0,0,0,7,0,0,8,0,0, 0,0,6,0,0,0,0,3,1, 0,4,0,0,0,2,0,0,0, 0,2,4,0,7,0,0,0,0, 0,1,0,0,3,0,0,8,0, 0,0,0,0,6,0,2,9,0, 0,0,0,8,0,0,0,7,0, 8,6,0,0,0,0,5,0,0, 0,0,2,0,0,6,0,0,0] , [0,0,1,0,0,7,0,9,0, 5,9,0,0,8,0,0,0,1, 0,3,0,0,0,0,0,8,0, 0,0,0,0,0,5,8,0,0, 0,5,0,0,6,0,0,2,0, 0,0,4,1,0,0,0,0,0, 0,8,0,0,0,0,0,3,0, 1,0,0,0,2,0,0,7,9, 0,2,0,7,0,0,4,0,0] , [0,0,0,0,0,3,0,1,7, 0,1,5,0,0,9,0,0,8, 0,6,0,0,0,0,0,0,0, 1,0,0,0,0,7,0,0,0, 0,0,9,0,0,0,2,0,0, 0,0,0,5,0,0,0,0,4, 0,0,0,0,0,0,0,2,0, 5,0,0,6,0,0,3,4,0, 3,4,0,2,0,0,0,0,0] , [3,0,0,2,0,0,0,0,0, 0,0,0,1,0,7,0,0,0, 7,0,6,0,3,0,5,0,0, 0,7,0,0,0,9,0,8,0, 9,0,0,0,2,0,0,0,4, 0,1,0,8,0,0,0,5,0, 0,0,9,0,4,0,3,0,1, 0,0,0,7,0,2,0,0,0, 0,0,0,0,0,8,0,0,6]]

puts pe($all_sudokus)