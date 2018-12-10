.data
 	buforTekst: .space 17
 	buforKlucz: .space 9
 	pytanieTekst: .asciiz "\nPodaj tekst (max 16 znakow): "
 	pytanieKlucz: .asciiz "\nPodaj klucz (min 1 znak, max 8 znakow): "
 	pytanieOperacja:.asciiz "Podaj kod operacji (0 - szyfrowanie, 1 - odszyfrowanie): "
.text
Main:
	#Pytanie o kod operacji
	la $a0, pytanieOperacja
	li $v0, 4
	syscall
 	li $v0,5
 	syscall
 	move $s0,$v0

 	#Pytanie o klucz
Klucz:
	la $a0, pytanieKlucz 
	li $v0, 4
	syscall

	la $a0, buforKlucz
	li $a1, 9 
	li $v0, 8
	syscall
	lb $t0, ($a0)
 	blt $t0, 97, Klucz
 	#sprawdz czy zawiera poprawne znaki (97-122) i jesli nie to idz do szyfr
 
 	move $s1, $a0
 
 	#Pytanie o tekst
Tekst:
	la $a0, pytanieTekst
	li $v0, 4
	syscall

	la $a0, buforTekst
	li $a1, 17
	li $v0, 8
	syscall
 	#sprawdz czy zawiera poprawne znaki (97-122) i jesli nie to idz to szyfr
 
 la $a0, buforTekst
	li $v0, 4
	syscall
 	move $s2, $a0

	add $t1, $zero, $zero	# tekst licznik

ZerujLicznikKlucza:
	add $t0, $zero, $zero	# klucz licznik

Petla:
	add $t2, $s1, $t0
	lb $t2, ($t2)
	blt $t2, 'a', ZerujLicznikKlucza	
	bgt $t2, 122, ZerujLicznikKlucza
	
	add $t3, $s2, $t1
 	lb $t3, ($t3)
 
	blt $t3, 97, Koniec	# jeśli biezacy znak tekstu to null to zakoncz
 	bgt $t3, 122, Koniec 
 	beq $s0, 1, Odszyfruj 
 	
Zaszyfruj:
	add $t3, $t3, $t2
	sub $t3, $t3, 97
	ble $t3, 122, Wyswietl
	sub $t3, $t3, 26
	j Wyswietl	

Odszyfruj:
	sub $t3, $t3, $t2
	add $t3, $t3, 97
	bge $t3, 97, Wyswietl
	add $t3, $t3, 26

Wyswietl:
 	move $a0, $t3
 	li $v0, 11
 	syscall
 
 	add $t0, $t0, 1		# zwieksz licznik klucza
 	add $t1, $t1, 1		# zwieksz licznik tekstu
 	j Petla 

Koniec:
	li $v0, 10
	syscall
