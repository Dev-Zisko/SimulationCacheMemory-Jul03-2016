TITLE MASM Template						(main.asm)

;INCLUDE Irvine32.inc
.data
num DW 0
cont DW 0
mp DW 1024 ; tamaño memoria principal
mc DW 64 ; tamaño memoria cache
tamanio DW 0
tag DW 0

txtTamanio DB "Tamanio: ",0
txtTag DB "Tag: ",0
txtLinea DB "Linea: ",0
txtConjunto DB "Conjunto: ",0
txtByte DB "Byte: ",0

linea DW 0
bte DW 0 ; byte
tb DW 2; tamaño bloque
tc DW 2; tamaño conjunto
dir DW 10
aux DW 0
binario dd 5 dup (0)
tipo DW 2
.code

log2 PROC
	mov cont,0
	mov ax,num ;mueve el numero dado al registro ax
	while1:
	mov dx,0 ; seteo dx en 0
	mov bx,2 ; seteo bx en 2
	div bx ; ax = ax div 2 dx = ax % 2
	inc cont ; cont= cont+1
	cmp dx, 0
	jz while1 ; if dx==0 salta a while1
	dec cont ; cont = cont-1 Resultado
	ret
log2 ENDP

modulo1 PROC

	
	
	
	;Calcular byte
	mov ax,tb
	mov num,ax
	call log2
	mov ax,cont ; return de log2(byte=log2(tb))
	mov bte,ax

	
	;Calcular linea u conjunto
	.IF tipo==1
	mov ax,mc
	mov bx,tb
	div bx
	mov num,ax
	call log2
	mov ax,cont ; return de log2(linea=log2(ax))
	mov linea,ax
	

	.ELSEIF tipo==2
	 mov ax,mc
	 mov bx,tb
	 div bx
	 mov bx,tc
	 div bx
	 mov num,ax
	 call log2
	 mov ax,cont
	 mov linea,ax
	.ENDIF

	
	;Calcular Tag
	.IF tipo==1
	mov ax,tamanio
	sub ax,linea
	sub ax,bte
	mov tag,ax
	

	.ELSEIF tipo==2
	mov ax,mp
	mov bx,tb
	div bx
	mov num,ax
	call log2
	mov ax,cont
	sub ax,linea
	mov tag,ax
	.ENDIF

	
	;calcular Tamaño
	.IF tipo==1
	mov ax,mp 
	mov num,ax ; num = mp
	call log2
	mov ax,cont 
	mov tamanio, ax ; return de log2 (tamanio=log2(mp))
	
	.ELSEIF tipo==2
	mov ax,tag
	add ax,linea
	add ax,bte
	mov tamanio,ax
	.ENDIF

	
	;Llenar arreglo	
	mov ax,dir
	mov esi,tamanio
	
		mov ax,tipo
		call writeint
		call Crlf
	
	while2:
		mov dx,0
		cmp esi,0
		jle while2fin ;jump if <=
		dec esi
		mov bx,2
		div bx
		mov binario[esi*4],dx
		jmp while2
	while2fin:

	mov ax,tipo
		call writeint
		call Crlf
	

		
	

; Mostrar Datos
		mov dx,OFFSET txtTamanio
		call writeString
		mov cx,0
		mov ax,tamanio
		call writedec
		call Crlf

		mov dx,OFFSET txtTag
		call writeString
		mov ax,tag
		call writedec
		call Crlf

		mov dx,OFFSET txtLinea
		call writeString
		mov ax,linea
		call writedec
		call Crlf

		mov dx,OFFSET txtByte
		call writeString
		mov ax,bte
		call writedec
		call Crlf
		call Crlf

		
	;MostrarArreglo

		; Ciclo para escribir la seccion tag
		.while(cx<tag)
		mov ax,binario[cx*4]
		call writedec
		mov al,"t"
		call writechar
		mov al," "
		call writechar
		inc cx
		.endw

		;Ciclo para escribir la seccion de linea
		
		mov ax,tag
		add ax,linea
		mov dx, ax
		mov cx, tag
		.while(cx<dx)		
		mov ax,binario[cx*4]
		call writedec
		
		
		cmp tipo,1
		je l1
		cmp tipo,2
		je l2
	l1:		
		mov al,"l"
		call writechar
		jmp l3

		
	l2:
		mov al,"c"
		call writechar
		jmp l3

	l3:
		mov al," "
		call writechar
		inc cx
		.endw

		;Ciclo para escribir la seccion de byte

		mov ax,tag
		add ax,linea
		mov cx,ax
		.while(cx<tamanio)
		 mov ax,binario[cx*4]
		 call writedec
		 mov al,"b"
		 call writechar
		 mov al," "
		 call writechar
		 inc cx
		 .endw
		 call crlf
		 ret


modulo1 ENDP

main PROC
	
call modulo1	

	

	exit
main ENDP
END main