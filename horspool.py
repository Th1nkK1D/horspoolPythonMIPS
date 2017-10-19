# Mini Project 1 - Horspool Algorithm
# CPE 325 - 1/2560
# Team Mid 4 ggez

# Get input
text = ""
pattern = ""

while len(text) <= 0:
    text = input("Enter text: ")

while len(pattern) <= 0:
    pattern = input("Enter pattern: ")

# Init Data for Horspool
found = 0
i = 0
m = len(pattern)
n = len(text)

# Start of Horspool algorithm
while i <= n-m:
    j = m-1

    while j >= 0 and pattern[j] == text[i+j]:
        j = j-1

    if j < 0:
        found = found+1

    i = i + m-1

    # Find occ
    occ = m - 2

    while occ >= 0:
        if pattern[occ] == text[i]:
            break
        occ = occ-1

    # Shift
    i = i - occ
    

# Print result
print('Found',found,'matches')
