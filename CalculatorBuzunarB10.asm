 .386
.model flat, stdcall
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;includem biblioteci, si declaram ce functii vrem sa importam
includelib msvcrt.lib
extern exit: proc
extern printf: proc
extern scanf: proc
extern gets: proc
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;declaram simbolul start ca public - de acolo incepe executia
public start
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;sectiunile programului, date, respectiv cod
.data
;;;;;;;;;;;;;;;;;;;;;;;;;;;VARIABILE PRINCIPALE;;;;;;;;;;;;;;;;;;;;;;;;
rezultat_final dd 0
x db 100 dup(0)
lgx dd 0
op db 100 dup(0)
op_c dd 0
num dd 100 dup(0)
num_c dd 0
istorie dd 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;SCANF PRINTF;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
msg1 db "> Introduceti o expresie:  ",10,13, 0
format_d db "=%d",10,13,0
error_msg1 db "Si ti-am zis sa nu imparti cu zero !",10,13
error_msg2 db 		"......................................__....................................................",10,13
error_msg3 db		".............................,-~*`¯lllllll`*~,.............................................",10,13
error_msg4 db 		".......................,-~*`lllllllllllllllllllllllllll¯`*-,...............................",10,13
error_msg5 db 		"..................,-~*llllllllllllllllllllllllllllllllllllllllllll*-,.......................",10,13
error_msg6 db 		"...............,-*llllllllllllllllllllllllllllllllllllllllllllllllllllll.\..................",10,13
error_msg7 db 		".............;*`lllllllllllllllllllllllllll,-~*~-,llllllllllllllllllll\.....................",10,13
error_msg8 db 		"..............\lllllllllllllllllllllllllll/.........\;;;;llllllllllll,-`~-,.................",10,13
error_msg9 db		"...............\lllllllllllllllllllll,-*...........`~-~-,...(.(¯`*,`,......................",10,13
error_msg10 db 		"................\llllllllllll,-~*.....................)_-\..*`*;..).........................",10,13
error_msg11 db 		".................\,-*`¯,*`)............,-~*`~................/.............................",10,13
error_msg1111 db 	"..................|/.../.../~,......-~*,-~*`;................/.\............................",10,13
error_msg12 db 		"................./.../.../.../..,-,..*~,.`*~*................*...\..........................",10,13
error_msg13 db 		"................|.../.../.../.*`...\...........................)....)¯`~,..................",10,13
error_msg14 db 		"................|./.../..../.......)......,.)`*~-,............/....|..)...`~-,..............",10,13
error_msg15 db 		"..............././.../...,*`-,.....`-,...*`....,---......\..../...../..|.........¯```*~-,,,",10,13
error_msg16 db 		"...............(..........)`*~-,....`*`.,-~*.,-*......|.../..../.../............\......../..",10,13
error_msg17 db 		"................*-,.......`*-,...`~,..``.,,,-*..........|.,*...,*...|..............\........",10,13
error_msg18 db 		"...................*,.........`-,...)-,..............,-*`...,-*....(`-,............\........",10,13
error_msg19 db		"......................f`-,.........`-,/...*-,___,,-~*....,-*......|...`-,..........\........",10,13,0


;;;;;;;;;;;;;;;;;;;;;;;;;;VARIABILE AJUTATOARE;;;;;;;;;;;;;;;;;;;;;;;;;;
n dd 0
initial db "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",10,13
reguli db "Pentru a utiliza corect calculatorul de buzunar, va rog sa urmati urmatoarele reguli: ",10,13
regula1 db " 1. Nu impartiti cu 0(zero)",10,13
regula2 db " 2. Expresia trebuie sa fie de forma numar operator numar egal: exemplu: 12-34/18+9=",10,13
regula3 db " 3. Operatii admise: + adunare, - scadere, * inmultire, / impartire",10,13
regula4 db " 4. Pentru a iesi din program, trebuie sa scrieti: exit (in locul expresiei)",10,13
final db   "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" ,10,13,0
mesaj_final db "Multumesc pentru ca ati utilizat calculatorul meu de buzunar!",10,13,0



.code

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;functie de eliminare a spatiilor
fara_spatii proc
push ebp
mov ebp, esp

mov ebx,0
mov ecx, [ebp+8]
mov edx,ecx
mov esi,0
mov eax,0

for1_fara_spatii:
			
	cmp x[esi],' '
	jne sf_if_fara_spatii			
		mov eax, esi
		for2_fara_spatii:
		cmp eax,edx
		je sf_for2_fara_spatii	
			mov bl,x[eax+1]
			mov x[eax], bl			
			inc eax
			jmp for2_fara_spatii
		sf_for2_fara_spatii:
		dec esi
		dec edx
			
		sf_if_fara_spatii:
		inc esi
	loop for1_fara_spatii
	
	mov esp,ebp
	pop ebp
ret 4
fara_spatii  endp

curatare_vectori proc
push ebp
mov ebp, esp

mov ecx,0
mov ecx,100
mov esi,0
curatare:
	mov num[esi],0
	mov op[esi],0
	mov x[esi],0
	inc esi
loop curatare
mov esp,ebp
pop ebp
ret 
curatare_vectori endp


start:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;RULES
	push offset initial
	call printf
	add esp,4

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;citire string
	push offset msg1
	call printf
	add esp, 4
	
	push offset x	
	call gets
	add esp, 4
	mov esi,0
	cmp x[esi],'e'
	je go_to_exit
	jne sa_inceapa_aventura
	sa_inceapa_aventura:
	
	mov op_c, 0
	mov num_c, 0
	mov n, 0
	
	;;;;;;;;;; lungimea stringului
	mov esi,0
	mov ecx,100
	
	lungime_string:
	cmp x[esi],0
	je nimic 
	inc esi
	loop lungime_string
	nimic: 
	
	mov lgx, esi
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;eliminare spatii
	push lgx
	call fara_spatii
	
	mov lgx, edx
	
	
	;;;;;;;;;;;;;;;;;;;;; adaugare '+' in capatul stringului
	
	mov esi, lgx	
	mov x[esi-1],'+'
	inc esi
	mov lgx,esi
	
	mov eax, rezultat_final
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;utilizare history
	cmp x[0],'+'
	jne verificare_scadere
	je adaugare
	verificare_scadere:
	cmp x[0],'-'
	jne verificare_inmultire
	je adaugare
	verificare_inmultire:
	cmp x[0],'*'
	je adaugare
	jne verificare_impartire
	verificare_impartire:
	cmp x[0],'/'
	je adaugare
	jne fara_istorie
	
	adaugare:
	mov esi, op_c
	mov dl,x[0]
	mov op[esi],dl
	inc op_c	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;adaugare istorie
	mov esi, num_c
	mov num[esi], eax
	add num_c,4
	fara_istorie:
	
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;verificare daca s-a utilizat istoria
	mov esi, 0
	
	cmp num_c, 0
	jne algoritm_cu_istorie
	jmp formare_vectori
	algoritm_cu_istorie:
		inc esi
	
	
	mov n,0
	formare_vectori:
		cmp x[esi],'+'
		jne verificare_scadere2
		je adaugare2
		verificare_scadere2:
		cmp x[esi],'-'
		jne verificare_inmultire2
		je adaugare2
		verificare_inmultire2:
		cmp x[esi],'*'
		je adaugare2
		jne verificare_impartire2
		verificare_impartire2:
		cmp x[esi],'/'
		je adaugare2
		jne formare_numar
			adaugare2:
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;adaugare de operator
				mov edi,0
				mov edx,0
				mov edi, op_c
				mov dl,x[esi]
				mov op[edi], dl
				inc op_c
				;;;;;;;;;;;;;;;;;;;;;;;;;;;;;adaugare numar
				
				add esp, 8
				mov edi,0
				mov edx,0
				mov edi, num_c
				mov edx, n
				mov num[edi], edx
				push edi
				push num[edi]
				add num_c,4
				mov n, 0
				jmp terminare_formare_vectori
			formare_numar:
				mov eax,0
				mov edx,0
				mov eax, n
				mov dx, 10
				mul dx
				mov edx, 0
				mov dl, x[esi]
				sub dl, '0'
				mov ebx,0 
				mov bl, dl
				add eax, ebx
				mov n,0
				mov n, eax
				
					
	terminare_formare_vectori:
	inc esi
	cmp esi, lgx
	je iesire_formare_vectori
	jmp formare_vectori
	
	iesire_formare_vectori:
	
	
	
	mov esi,0
	for_operatii_prioritare:
		cmp op[esi],'*'
		je inmultire
		jne impartire
		inmultire:
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;aflare pozitie al doilea numar: contor=edi
		mov eax,0
		mov eax, esi
		inc eax
		mov ebx,0
		mov ebx,4
		mul ebx
		mov edi,0
		mov edi, eax
		mov eax, 0
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;aflare pozitie primul numar: contor=esi
		mov eax,esi
		push esi
		mov ebx,0
		mov ebx,4
		mul ebx
		mov esi,0
		mov esi, eax
		mov eax,0
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;efectuare inmultire
		mov eax,num[edi]
		mul num[esi]
		mov num[edi],eax
		mov esi,0
		;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;readucerea lui esi la pozitia de contor pentru operatori
		pop esi
		mov op[esi],'?'
		
		jmp pasul_urmator
	
		impartire:
		mov eax,0
		mov eax, esi
		inc eax
		mov ebx,0
		mov ebx,4
		mul ebx
		mov edi,0
		mov edi, eax
		cmp num[edi],0
		je error_impartire
		jne verificare_impartire3
			error_impartire:
			push offset error_msg1
			call printf
			add esp,4
			jmp urmatoarea_ecuatie
		verificare_impartire3:
		cmp op[esi],'/'
		je efectuare_impartire
		jne pasul_urmator
			efectuare_impartire:
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;aflare pozitie al doilea numa numar: contor = edi
			mov eax,0
			mov eax, esi
			inc eax
			mov ebx,0
			mov ebx,4
			mul ebx
			mov edi,0
			mov edi, eax
			mov eax,0
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;aflare pozitie primul numar: contor=esi
			mov eax,esi
			push esi
			mov ebx,0
			mov ebx,4
			mul ebx
			mov esi,0
			mov esi, eax
			mov eax,0
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;efectuare impartire
			cmp num[esi],0
			jl efectuare_impartire_numar_negativ
			jge efectuare_impartire_normal
			efectuare_impartire_normal:
			mov eax,0
			mov eax, num[esi]
			div num[edi]
			mov ebx,0
			mov bl,al
			mov num[edi],ebx
			mov esi,0
			jmp esi_la_normal
			efectuare_impartire_numar_negativ:
			mov eax,0
			mov eax, num[esi]
			neg eax
			div num[edi]
			neg eax
			mov num[edi],eax
			mov esi,0
			esi_la_normal:
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;readucerea lui esi la pozitia de contor pentru operatori
			pop esi
			;mov num[esi],-1
			mov op[esi],'?'
	pasul_urmator:
	inc esi
	mov eax,0
	mov eax, op_c
	dec eax
	cmp esi, eax
	je iesire_for_operatii_prioritare
	jb for_operatii_prioritare
	iesire_for_operatii_prioritare:
	
	
	
	mov esi,0
	for_ecuatii_secundare:
	cmp op[esi],'?'
	je pasul_urmator_for_operatii_secundare
	jne continuare_for_operatii_secundare
	continuare_for_operatii_secundare:
		mov edi,0
		mov edi, esi
		inc edi
		
		for2_operatii_secundare:
		cmp op[edi],'?'
		je continuare_for2_operatii_secundare
		jne iesire_for2_operatii_secundare
		continuare_for2_operatii_secundare:
		inc edi
		jmp for2_operatii_secundare
		iesire_for2_operatii_secundare:
		
		cmp op[esi],'+'
		je efectuare_adunare
		jne verificare_scadere3
		efectuare_adunare:
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;aflare pozitie al doilea numar: contor=ebx
			mov eax,0
			mov eax, edi
			mov ebx,0
			mov ebx,4
			mul ebx
			mov ebx,0
			mov ebx,eax
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;aflare pozitie primul numar: contor=ecx
			mov eax,0
			mov eax,esi
			mov ecx,0
			mov ecx,4
			mul ecx
			mov ecx,0
			mov ecx, eax
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;efectuare adunare
			mov eax,0
			mov eax,num[ebx]
			add eax, num[ecx]
			mov num[ebx],0
			mov num[ebx],eax
			
			mov op[esi],'?'
			jmp pasul_urmator_for_operatii_secundare
			
		verificare_scadere3:
		cmp op[esi],'-'
		je efectuare_scadere
		jne pasul_urmator_for_operatii_secundare
		efectuare_scadere:
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;aflare pozitie al doilea numar: contor=ebx
			mov eax,0
			mov eax, edi
			mov ebx,0
			mov ebx,4
			mul ebx
			mov ebx,0
			mov ebx,eax
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;aflare pozitie primul numar: contor=ecx
			mov eax,0
			mov eax,esi
			mov ecx,0
			mov ecx,4
			mul ecx
			mov ecx,0
			mov ecx, eax
			;;;;;;;;;;;;;;;;;;;;;;;;;;;;efectuare adunare
			mov eax,0
			mov eax,num[ecx]
			sub eax, num[ebx]
			mov num[ebx],0
			mov num[ebx],eax
			
			mov op[esi],'?'
		pasul_urmator_for_operatii_secundare:
		inc esi
		mov eax,0
		mov eax,op_c
		dec eax
		cmp esi,eax
		je sfarsit_for_operatii_secundare
		jb for_ecuatii_secundare
	
	sfarsit_for_operatii_secundare:
	
	
	mov eax,0
	mov ebx,num_c
	sub ebx,4
	mov eax, num[ebx]
	mov rezultat_final,0
	mov rezultat_final,eax
	
	push eax
	push offset format_d
	call printf
	add esp,8
	
	call curatare_vectori
	urmatoarea_ecuatie:
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	push offset msg1
	call printf
	add esp, 4
	
	push offset x	
	call gets
	add esp, 4
	
 	cmp x,'e'
	je go_to_exit
	jne sa_inceapa_aventura
	go_to_exit:
	
	push offset mesaj_final
	call printf
	add esp,4
	;terminarea programului
	push 0
	call exit
end start