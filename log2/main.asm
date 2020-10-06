TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
myMessage BYTE "Assembly language program example",0dh,0ah,0
num DWORD 128
cont DWORD 0
mp DWORD 1024; tamaño memoria principal
mc DWORD 64 ; tamaño memoria cache
tamanio DWORD 20
tag DWORD 0
.code

main PROC
	mov cont,0
	mov eax,num ;mueve el numero dado al registro eax
	while1:
	mov edx,0 ; seteo edx en 0
	mov ebx,2 ; seteo bx en 2
	div ebx ; eax = eax div 2 edx = eax % 2
	inc cont ; cont= cont+1
	cmp edx, 0
	jz while1 ; if edx==0 salta a while1
	dec cont ; cont = cont-1 Resultado
	mov eax,cont
	call writedec
	exit
main ENDP

END main