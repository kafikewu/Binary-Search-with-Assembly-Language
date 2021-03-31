mvi l, 03h
mov a, l
sta 000BH ; 000bh stores the size of the array and in turn controlls how many time the loop iterates
loop2: mvi b, 00h
mvi c, 00h
mvi d, 00h
mvi e, 01h
mvi l, 03h
loop1: ldax b
mov h, a
ldax d
cmp h
cc greater
inr e
inr c
mov a, l
dcr a
mov l, a
jnz loop1
lda 000BH
dcr a
sta 000BH
jnz loop2
;done with sorting
;000ch should hold the sreached value
;000dh - start
;000eh - mid
;000fh - end

LOOP3: mvi a, 00h
mvi b, 00h
mvi d, 00h
mvi h, 00h
mvi c, 0dh
mvi e, 0eh
mvi l, 0fh
ldax b
mov c, a
mov a, m
mov l, a
mov a, l
cmp c
jc halt
mov a, l
sub c
sta 0031H
call division
lda 0033H
mov d, a
lda 000DH
add d
sta 000EH
lda 0eh
mov e, a
mvi d, 00h
ldax d
mov b, a
lda 000CH
cmp b
cnc greaterorequal
cc smaller
jmp LOOP3


greater: stax b
mov a, h
stax d
ret


division: lhld 31H ;leave 32H alone
MVI B,02H
MVI C, 08
UP: DAD H
MOV A, H
SUB B
JC DOWN
MOV H, A
INR L
DOWN: DCR C
JNZ UP
SHLD 0033H
ret


halt: MVI A, 100
STA 000AH
hlt; have to think about later


incrementlower: lda 000EH
inr a
sta 000DH
ret ;change it


equal: mvi a, 200
sta 000AH
hlt

greaterorequal: cz equal
cnz incrementlower
ret
;jnz incrementlower

smaller: lda 000EH
dcr a
sta 000FH
ret

