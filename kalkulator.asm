.data
	pierwszy: .asciiz "Pierwszy skladnik: "
	kod: .asciiz "Kod dzialania: "
	drugi: .asciiz "Drugi skladnik: "
	wynik: .asciiz "wynik = "
	pytanie: .asciiz "\n\nCzy wykonac kolejna operacje? [1/0]"
	opis: .asciiz "***** Kalkulator *****\n[liczba][kod dzialania][liczba]\nDostepne kody dzialan:\n0: +\n1: -\n2: *\n3: /\n"
.text 
main:
	la $a0, opis
	li $v0, 4
	syscall
	
	la $a0, pierwszy
	li $v0, 4
	syscall
	li $v0, 7
	syscall
	mov.d $f2, $f0
	
operator:	
	la $a0, kod
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	bltz $v0, operator
	bgt $v0, 3, operator
	move $t1, $v0
	
	la $a0, drugi
	li $v0, 4
	syscall
	li $v0, 7
	syscall
	
	beq $t1, 0, dodawanie
	beq $t1, 1, odejmowanie
	beq $t1, 2, mnozenie
	beq $t1, 3, dzielenie
	
wyniki:
 	la $a0, wynik
 	li $v0, 4
 	syscall
 	li $v0, 3 
	syscall
	
	la $a0, pytanie
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	beq $v0, 1, main
	
	li $v0, 10
	syscall
	
dodawanie:
	add.d $f12,$f2,$f0
	j wyniki
odejmowanie:
	sub.d $f12,$f2,$f0
	j wyniki
mnozenie:
	mul.d $f12,$f2,$f0
	j wyniki
dzielenie:	
	div.d $f12,$f2,$f0
	j wyniki
