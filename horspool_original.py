# Mini Project 1 - Horspool Algorithm
# CPE 325 - 1/2560
# Team Mid 4 ggez

import sys
import string

# print process
def printprocess(shift):
    print(text)
    for i in range(0,shift):
        print(" ",end="")
    print(pattern)

# preprocess - initialize occ
def preprocess(pattern):
    occ = dict.fromkeys(string.ascii_lowercase, -1)

    for i in range(0,len(pattern)-1):
        occ[pattern[i]] = i

    return occ

# seach - find string with horspool
def search(text,pattern,occ):
    found = 0
    i = 0
    m = len(pattern)
    n = len(text)


    while i <= n-m:
        printprocess(i)
        
        j = m-1

        while j >= 0 and pattern[j] == text[i+j]:
            j = j-1

        if j < 0:
            found = found+1
            print("found!")

        i = i + m-1
        i = i - occ[text[i]]

    return found

# main
text=""
pattern=""

while len(text) <= 0:
    text = input("Enter text: ")

while len(pattern) <= 0:
    pattern = input("Enter pattern: ")

occ = preprocess(pattern)
found = search(text,pattern,occ)

print('Found',found,'matches')
