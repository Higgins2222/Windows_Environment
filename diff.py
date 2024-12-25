import sys
import os

CYAN = '\033[96m'
GREEN = '\033[92m'
BEIGE = '\033[93m'

file1 = sys.argv[1]
file2 = sys.argv[2]

if os.path.exists(file1):
    print(file1)
else:
    print(f'{file1}, File does not exist')
    exit()

if os.path.exists(file2):
    print(file2)
else:
    print(f'{file2}, File does not exist')
    exit()

lines_1 = []
with open(file1, 'r') as file:
    for line in file:
        lines_1.append(line.rstrip())

lines_2 = []
with open(file2, 'r') as file:
    for line in file:
        lines_2.append(line.rstrip())


# Initialize 2D array
dp = [[0] * (len(lines_2) + 1) for _ in range(len(lines_1) + 1)]

# Fill the dp table
for i in range(1, len(lines_1) + 1):
    for j in range(1, len(lines_2) + 1):
        if lines_1[i - 1] == lines_2[j - 1]:
            dp[i][j] = dp[i - 1][j - 1] + 1
        else:
            dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])


# Backtrack to find the LCS
i, j = len(lines_1), len(lines_2)
lcs = []

while i > 0 and j > 0:
    if lines_1[i - 1] == lines_2[j - 1]:
        lcs.append(lines_1[i - 1])  # Add the matching line to the LCS
        i -= 1
        j -= 1
    elif dp[i - 1][j] > dp[i][j - 1]:
        i -= 1  # Move up
    else:
        j -= 1  # Move left

lcs.reverse()  # Reverse the LCS since we collected it backwards


# Initialize indices
i, j, k = 0, 0, 0  # i: lines_1, j: lines_2, k: LCS


# Traverse the files
while i < len(lines_1) or j < len(lines_2):
    if k < len(lcs) and i < len(lines_1) and lines_1[i] == lcs[k] and j < len(lines_2) and lines_2[j] == lcs[k]:
        # LCS match, advance all
        print(f"{CYAN}{lines_1[i]}")  # No change
        i += 1
        j += 1
        k += 1
    elif i < len(lines_1) and (k >= len(lcs) or lines_1[i] != lcs[k]):
        # Deletion in lines_1
        print(f"{GREEN}{lines_1[i]}")  # Deleted
        i += 1
    elif j < len(lines_2) and (k >= len(lcs) or lines_2[j] != lcs[k]):
        # Insertion in lines_2
        print(f"{BEIGE}{lines_2[j]}")  # Inserted
        j += 1
