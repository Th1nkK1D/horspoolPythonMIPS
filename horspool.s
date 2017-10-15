# Mini Project 1 - Horspool Algorithm
# CPE 325 - 1/2560
# Team Mid 4 ggez

.data # Data segment
text: .space 256
pattern: .space 256
str1: .asciiz "Enter text: "
str2: .asciiz "Enter pattern: "
str3: .asciiz "Found: "


.text # Text Segment

j main

len:
    addi $t8, $zero, 0              # i = 0
    
    lenloop:
        lb $t9 0($a0)               # t9 = a[i]
        beq $t9, '\n', endlenloop   # if a[i] = '\n' -> endloop
        addi $t8, $t8, 1            # i++
        addi $a0, $a0, 1            # a0 = a[i]
        j lenloop
    endlenloop:

    add $v0, $t8, $zero             # return i
    jr $ra


main:
    addi $v0, $zero, 4				# v0 = 4
    la $a0, str1					# load text from str1 to a0
    syscall							# print "Enter Text: "
    addi $v0, $zero, 8				# v0 = 8
    la $a0, text 					# laod space of array into a0
    addi $a1 , $0 , 256				# set maximum of array 
    add $t1, $a0 , $0				# t1 = a0
    syscall							# Get source from user

    addi $v0, $zero, 4				# v0 = 4
    la $a0, str2   					# load text from str2 to a0
    syscall							# print "Enter pattern: "
    addi $v0, $zero, 8				# v0 = 8
    la $a0, pattern					# laod space of array into a0
    addi $a1,$0, 256				# set maximum of array 
    add $t2 , $a0 , $0				#t2 = a0
    syscall 						# Get source from user
    
    

    addi $s0, $zero, 0              # found = 0
    addi $t5, $zero, 0              # i = 0
    
    add $a0, $zero, $t2             # m = len(pattern)
    jal len
    add $t3, $zero, $v0

    add $a0, $zero, $t1             # n = len(text)
    jal len
    add $t4, $zero, $v0

    bigloop:
        sub $t8, $t4, $t3           # t8 = n-m
        slt $t8, $t8, $t5           # t8 = i > n-m
        bne $t8, $zero, endbigloop  # if i <= n-m -> endbigloop

        add $t6,$t3,-1                      # j = m - 1
        loopcheck:  slt $t0,$t6,$zero       # if j < 0 --> t0 = 1
                bne $t0,$zero,endloopcheck  # true --> endloopcheck
                add $t8,$t5,$t6     # i + j
                add $t8,$t8,$t1     # &text[i + j]
                lb $t8,0($t8)       # text[i + J]
                add $t0,$t6,$t2     # &pattern[j]
                lb $t0,0($t0)       # pattern[j]
                bne $t0,$t8,endloopcheck    # not equal between pattern[j] and text[i + J] --> endloopcheck
                addi $t6,$t6,-1     # j = j - 1
                j loopcheck
        endloopcheck:	
                slt,$t0,$t6,$zero   # if j < 0 --> t0 = 1 
                beq $t0,$zero,notfound       # true --> founded	
                addi $s0,$s0,1  # found = found + 1
        notfound:
                addi $t8,$t3,-1     # m - 1
                add $t5,$t5,$t8     # i = i + (m - 1)


        addi $t7,$t3,-2             # occ = m - 2

        loopocc:
            slt $t8,$0,$t7          # t8 = 0 < occ
            beq $t8,$0,endloopocc   # if t8 = 0 mean 0 >= occ go to endloop
            add $t9,$t2,$t7         # t9 = &pattern[0] + occ , &pattern[occ]
            add $t0,$t1,$t5         # t10 = &text[0] + t10 , &text[i]
            lb $t9,0($t9)           # t8 = pattern[occ]
            lb $t0,0($t0)           # t7 = text[i]
            beq $t9,$t0,endloopocc  # if t8 = t7 go to endloop
            addi $t7,$t7,-1         # if so occ = occ - 1
            j loopocc
        endloopocc:
        sub $t5,$t5,$t7             # i = i - occ
        
        j bigloop

    endbigloop:

    addi $v0, $zero, 4				# v0 = 4
		la $a0, str3				# load text from str3 to a0
		syscall						# print "Found: "
		addi $v0, $zero, 1			#v0 = 1
		add $a0, $s0, $zero			#a0 = s0
		syscall						# print integer from a0
		addi $v0, $zero, 10			# v0 = 10
		syscall						# exit the program
