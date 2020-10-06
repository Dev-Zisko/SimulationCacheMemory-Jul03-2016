TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

i DWORD ?
acierto DWORD ?
ff DWORD 0
fc DWORD 0
num DWORD ?
cont DWORD 0
tamanio DWORD ?
tag DWORD ?
txtTamanio byte "Tamanio: ",0
txtTag byte "Tag: ",0
txtLinea byte "Linea: ",0
txtConjunto byte "Conjunto:",0
txtParticionLinea byte " El bloque se colocara en la linea de la memoria cache: ",0
txtParticionConjunto byte " El bloque se colocara en el conjunto de la memoria cache: ",0
txtByte byte "Byte: ",0
txtmsg1 byte "Ingrese la cantidad de direcciones",0
txtmsg2 byte "Ingrese la direccion",0
txtft byte "Fallas totales: ",0
txtff byte "Fallas forzosas: ",0
txtfc byte "Fallas por conflicto: ",0
txttf byte "Tasa de fallas: ",0
txtac byte "Aciertos totales: ",0
txtta byte "Tasa de aciertos: ",0

linea DWORD 0
bte DWORD 0 ; byte
particion DWORD ?
aux DWORD 2 ; Usado para convertir la direccion de binario a decimal
binario dd 7 dup (0) ; arreglo binario
matriz1 dd 32 dup (0)
matriz2 dd 27 dup (0)
matriz3 dd 80 dup (0)
direcciones dd 20 dup(?)
tamDir DWORD 3
;bloque DWORD ?
;k DWORD ?

;Variables para el menu

tipo DWORD ?       ;Funcion de mapeo modulo 1
mp DWORD ?      ;Tamaño memoria principal
mc DWORD ?	     ;Tamaño memoria cache
tb DWORD ?    ;Tamaño de bloques
nc DWORD ?
tc DWORD ? ;Tamaño asociativo bloques
dir DWORD ?    ;Numero a buscar en modulo 1
opcion DWORD ?    ;Opcion para el menu


msg10 BYTE "                                          #                                                 ###",0dh,0ah,0
msg11 BYTE "#     #                                                  #####                                 ",0dh,0ah,0
msg12 BYTE "##   ##  ######  #    #   ####   #####   #    ##        #     #    ##     ####   #    #  ######",0dh,0ah,0
msg13 BYTE "# # # #  #       ##  ##  #    #  #    #  #   #  #       #         #  #   #    #  #    #  #     ",0dh,0ah,0
msg14 BYTE "#  #  #  #####   # ## #  #    #  #    #  #  #    #      #        #    #  #       ######  ##### ",0dh,0ah,0
msg15 BYTE "#     #  #       #    #  #    #  #####   #  ######      #        ######  #       #    #  #     ",0dh,0ah,0
msg16 BYTE "#     #  #       #    #  #    #  #   #   #  #    #      #     #  #    #  #    #  #    #  #     ",0dh,0ah,0
msg17 BYTE "#     #  ######  #    #   ####   #    #  #  #    #       #####   #    #   ####   #    #  ######",0dh,0ah,0
msg18 BYTE "                                                                                               ",0dh,0ah,0
msg20 BYTE "+-++-++-++-++-++-++-++-++-++-++          |    +-++-++-++-++-++-++-++-++-++-++-++-++            ",0dh,0ah,0
msg21 BYTE "|   Ubicacion de bloques:     |          |    | Simulador de reemplazo de bloques |            ",0dh,0ah,0
msg22 BYTE "+-++-++-++-++-++-++-++-++-++-++          |    +-++-++-++-++-++-++-++-++-++-++-++-++            ",0dh,0ah,0             
msg23 BYTE "                                         |                                                     ",0dh,0ah,0 
msg24 BYTE "1. Entrar a la seleccion.                |    2. Caso 1.                                       ",0dh,0ah,0
msg25 BYTE "                                         |                                                     ",0dh,0ah,0 
msg26 BYTE "                                         |    3. Caso 2.                                       ",0dh,0ah,0
msg27 BYTE "                                         |                                                     ",0dh,0ah,0 
msg28 BYTE "                                         |    4. Caso 3.                                       ",0dh,0ah,0
msg29 BYTE "                                         |                                                     ",0dh,0ah,0
msg30 BYTE "                                         |                               +-++-++-++-++-++-++-++",0dh,0ah,0
msg31 BYTE "                                         |                               | Marque su opcion:   ",0dh,0ah,0
msg32 BYTE "Seleccione la opcion de mapeo que desea: ",0dh,0ah,0
msg33 BYTE "1. Mapeo directo. ",0dh,0ah,0
msg34 BYTE "2. Mapeo asociativo por conjunto. ",0dh,0ah,0
msg35 BYTE "                                  ",0dh,0ah,0
msg36 BYTE "+-+-+-+-+-+-+",0dh,0ah,0
msg37 BYTE "+ Opcion:    ",0dh,0ah,0
msg38 BYTE "+-+-+-+-+-+-+",0dh,0ah,0
msg39 BYTE "Seleccione el tamanio en bytes de la memoria principal: ",0dh,0ah,0
msg40 BYTE "1. 32Kb",0dh,0ah,0
msg41 BYTE "2. 64Kb",0dh,0ah,0
msg42 BYTE "3. 128Kb",0dh,0ah,0
msg43 BYTE "4. 256Kb",0dh,0ah,0
msg44 BYTE "5. 512Kb",0dh,0ah,0
msg45 BYTE "6. 1Mb",0dh,0ah,0
msg46 BYTE "7. 2Mb",0dh,0ah,0
msg47 BYTE "8. 4Mb",0dh,0ah,0
msg48 BYTE "9. 8Mb",0dh,0ah,0
msg49 BYTE "10. 16Mb",0dh,0ah,0
msg50 BYTE "11. 32Mb",0dh,0ah,0
msg51 BYTE "Seleccione el tamanio en bytes de la memoria cache: ",0dh,0ah,0
msg52 BYTE "1. 64B",0dh,0ah,0
msg53 BYTE "2. 128B",0dh,0ah,0
msg54 BYTE "3. 256B",0dh,0ah,0
msg55 BYTE "4. 512B",0dh,0ah,0
msg56 BYTE "5. 1Kb",0dh,0ah,0
msg57 BYTE "Seleccione el tamanio en bytes del bloque: ",0dh,0ah,0
msg58 BYTE "1. 2B",0dh,0ah,0
msg59 BYTE "2. 4B",0dh,0ah,0
msg60 BYTE "3. 8B",0dh,0ah,0
msg61 BYTE "4. 16B",0dh,0ah,0
msg62 BYTE "5. 32B",0dh,0ah,0
msg63 BYTE "Seleccione el tamanio del conjunto en bloques: ",0dh,0ah,0
msg64 BYTE "1. 2",0dh,0ah,0
msg65 BYTE "2. 4",0dh,0ah,0
msg66 BYTE "3. 8",0dh,0ah,0
msg67 BYTE "Indique el numero en decimal del byte que desea buscar: ",0dh,0ah,0
msg68 BYTE "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+",0dh,0ah,0
msg69 BYTE "+ Numero:    ",0dh,0ah,0
msg70 BYTE "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+",0dh,0ah,0
msg71 BYTE "Memoria cache 1:",0dh,0ah,0
msg72 BYTE "Tamanio en bloques: 8",0dh,0ah,0
msg73 BYTE "Cantidad de conjuntos: 8",0dh,0ah,0
msg74 BYTE "Politica de reemplazo: FIFO",0dh,0ah,0
msg75 BYTE "Memoria cache 2:",0dh,0ah,0
msg76 BYTE "Tamanio en bloques: 16",0dh,0ah,0
msg77 BYTE "Memoria cache 3:",0dh,0ah,0
msg78 BYTE "Cantidad de conjuntos: 4",0dh,0ah,0
msg79 BYTE "Ingresa la cantidad de direcciones de la secuencia (maximo 20)",0dh,0ah,0
msg80 BYTE "Error. Solo se aceptan un maximo de 20 direcciones",0dh,0ah,0
msg81 BYTE "Indique el numero de la secuencia de direcciones:",0dh,0ah,0


.code
; Procedimiento que simula la funcion logaritmo base 2 del valor que se encuentra en num
log2 PROC
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
	ret
log2 ENDP

;Procedimiento que Realiza las funciones descritas en el modulo 1 del proyecto
modulo1 PROC

	;Calcula el tamaño de la secció byte independiente de si es mapeo directo o asociativo por conjunto
	mov eax,tb
	mov num,eax
	call log2
	mov eax,cont ; return de log2(byte=log2(tb))
	mov bte,eax

	; Mapeo Directo:
	.IF tipo==1 ; 

	;calcula el tamaño total de la memoria en mapeo directo
		mov eax,mp 
		mov num,eax ; num = mp
		call log2
		mov eax,cont 
		mov tamanio, eax ; return de log2 (tamanio=log2(mp))

	;calcula el tamaño de la seccion linea del mapeo directo
		mov eax,mc
		mov ebx,tb
		div ebx
		mov num,eax
		call log2
		mov eax,cont ; return de log2(linea=log2(eax))
		mov linea,eax
	

	;calcula el tamaño de la seccion Tag del mapeo directo
		mov eax,tamanio
		sub eax,linea
		sub eax,bte
		mov tag,eax

	; Mapeo Asociativo por Conjuntos
	.ELSEIF tipo==2
		mov eax,mc
		mov ebx,tb
		div ebx
		mov ebx,tc
		div ebx
		mov num,eax
		call log2
		mov eax,cont
		mov linea,eax
	
	;Calcula la seccion Tag del Mapeo Asociativo por conjuntos
		mov eax,mp
		mov ebx,tb
		div ebx
		mov num,eax
		call log2
		mov eax,cont
		sub eax,linea
		mov tag,eax

	;calcula el Tamaño total de la memoria (arreglo)
		mov eax,tag
		add eax,linea
		add eax,bte
		mov tamanio,eax
	.ENDIF

	;Llena el Arreglo independientemente si es mapeo directo o Asociativo por conjuntos
	mov eax,dir
	mov esi,tamanio
	while2:
		mov edx,0
		cmp esi,0
		jle while2fin ;jump if menor o igual
		dec esi
		mov bx,2
		div bx
		mov binario[esi*4],edx
		jmp while2
	while2fin:

; Muestra datos relevantes del modulo 1
	;Muestra el tamaño del arreglo
	mov edx,OFFSET txtTamanio
	call writeString
	mov eax,tamanio
	call writedec
	call Crlf
	;Muestra el Tamaño del Tag
	mov edx,OFFSET txtTag
	call writeString
	mov eax,tag
	call writedec
	call Crlf
	;Muestra el tamaño de la linea o conjunto segun el tipo de mapeo
	.IF(tipo==1)
		mov edx,OFFSET txtLinea
	.ELSEIF(tipo==2)
		mov edx,OFFSET txtConjunto
	.ENDIF
	call writeString
	mov eax,linea
	call writedec
	call Crlf
	; Muestra el tamaño de la seccion byte
	mov edx,OFFSET txtByte
	call writeString
	mov eax,bte
	call writedec
	call Crlf
	call Crlf

;MostrarArreglo
	mov ecx,0
	; Ciclo para escribir la seccion tag
	mov al,"["
	call writechar
	.while(ecx<tag)
		mov eax,binario[ecx*4]
		call writedec
		mov al,"t"
		call writechar
		mov al," "
		call writeChar
		inc ecx
	.endw
		
	mov al,"]"
	call writechar
	mov al," "
	call Writechar
	;Ciclo para escribir la seccion de linea y calcular la particion del bloque
	mov eax,tag
	add eax,linea
	mov edx, eax ; tag + linea
	mov ecx, tag ; mueve tag a ecx
	mov particion,0 ; inicializa la particion en 0
	mov al,"["
	call writechar
	.while(ecx<edx)		;mientras el contador en el registro ecx sea menor que edx(tag + linea)
		mov eax,binario[ecx*4]; mueve a eax, el valor del arreglo en la posicion ecx
		call writedec ; escribe el digito binario correspondiente a la posicion ecx
		push edx ; apila el valor de tag + linea
		push ecx; apila el valor del contador ecx
		push eax; apila el digito binario actual
		mov eax,2 ; eax = 2
		.IF (ebx == 2) ; si ebx es 2, mueve a eax 1
			mov eax,1
		.ELSE ; en caso de que ebx no sea 2, mueve a ebx 2 ( esto se hace para verificar si es el ultimo digito del binario y multiplicar por 2^0 en la conversion)
			mov ebx,2
		.ENDIF
		mov ecx,aux
		push ecx   ; Permite guardar ecx para luego aumentar a aux 1
		inc ecx
		mov aux, ecx
		pop ecx
		.while(ecx<linea)
			mul ebx
			inc ecx
		.endw
		mov ebx,eax	
		pop eax
		mul ebx
		mov ecx,eax
		mov eax,particion
		add eax,ecx
		mov particion, eax
		pop ecx
		pop edx
		.IF(tipo==1)
			mov al,"l"
			call writechar
		.ELSEIF(tipo==2)
			mov al,"c"
			call writechar
		.ENDIF
		mov al," "
		call writechar
		inc ecx
	.endw
	mov al,"]"
	call writechar
	mov al," "
	call Writechar

	;Ciclo para escribir la seccion de byte
	mov eax,tag
	add eax,linea
	mov ecx,eax
	mov al,"["
	call writechar
	.while(ecx<tamanio)
		mov eax,binario[ecx*4]
		call writedec
		mov al,"b"
		call writechar
		mov al," "
		call writechar
		inc ecx
	.endw
	 mov al,"]"
	call writechar
	mov al," "
	call Writechar

	;Escribir Particion
	call crlf
	call crlf
	.IF(tipo==1)
		mov edx,OFFSET txtParticionLinea
    .ELSEIF(tipo==2)
		 mov edx,OFFSET txtParticionConjunto
	.ENDIF
	 call writeString
	 mov eax, particion
	 call writedec
	 call crlf
	 call crlf
	 ret 
modulo1 ENDP

;Procedimiento que Realiza las funciones descritas en el modulo 2 opcion 1 del proyecto
modulo21 PROC
	mov ecx,0
	mov edx,0
	.while(ecx<tamdir)
		mov i,0
		mov edx,0
		mov eax, direcciones[ecx*4]
		push eax
		mov ebx, 1
		div ebx
		mov ebx, nc
		div ebx ; edx = fila 	
		pop eax
		.IF(matriz1[edx*4]==eax);direcciones[ecx*4]
			inc acierto
			inc i
		.ENDIF

		.IF(i==0)
			.IF(matriz1[edx*4]!=0)
				inc fc
			.ELSEIF(matriz1[edx*4]==0)
				inc ff
			.ENDIF
			mov eax, direcciones[ecx*4]
			mov matriz1[edx*4], eax
		.ENDIF	
		inc ecx
	.endw
	mov ecx,0
	mov edx,0
	.while(ecx<8)
		push eax
		mov edx,OFFSET txtConjunto
		mov eax,ecx
		call writeString
		call writedec
		mov al,':'
		call writeChar
		mov al,' '
		call writeChar
		pop eax
		mov eax,matriz1[ecx*4]
		call writedec
		call crlf
		inc ecx
	.endw

	;muestra falla forzosa opcion 1 modulo 2
	mov eax, ff
	mov edx, OFFSET txtff
	call crlf
	call writeString
	call writeDec
	call crlf

	;muestra falla por conflicto opcion 1 modulo 2
	mov eax, fc
	mov edx, OFFSET txtfc
	call writeString
	call writeDec
	call crlf

	;muestra fallas totales opcion 1 modulo 2
	mov eax, ff
	add eax, fc
	mov edx, OFFSET txtft
	call writeString
	call writeDec
	call crlf

	;muestra tasa de fallas opcion 1 modulo 2
	mov eax, ff
	add eax,fc
	mov ebx, 100
	mul ebx
	mov ebx,tamDir
	div ebx
	mov edx, OFFSET txttf
	call writeString
	call writeDec
	mov al,'%'
	call writeChar
	call crlf

	;muestra aciertos totales opcion 1 modulo 2
	mov eax, acierto
	mov edx, OFFSET txtac
	call writeString
	call writeDec
	call crlf

	; muestra tasa de aciertos opcion 1 modulo 2
	mov eax, acierto
	mov ebx, 100
	mul ebx
	mov ebx,tamDir
	div ebx
	mov edx, OFFSET txtta
	call writeString
	call writeDec
	mov al,'%'
	call writeChar
	call crlf
	call crlf
	ret

modulo21 ENDP

;Procedimiento que Realiza las funciones descritas en el modulo 2 opcion 2 del proyecto
modulo22 PROC
	mov ecx,0

	;Coloca cada elemento en la columna de contadores en 1
	mov eax,0
	mov esi,0
	.while(ecx<8)
		mov matriz2[esi],1
		add esi,12
		inc ecx
	.endw
	; Reemplazo tipo FIFO
	mov ecx,0
	.while(ecx<tamdir)
		mov edx,0
		mov eax, direcciones[ecx*4]
		mov ebx, 1
		div ebx
		mov ebx, nc
		div ebx	 ;devuelve en edx el numero de la fila

		; Verifica si hay aciertos
		mov i,0
		mov ebx, 1
		.while(ebx<=2)
			push edx ; guarda fila
			mov esi,direcciones[ecx*4]
			mov eax, edx ;fila
			push ebx
			mov ebx,3 
			mul ebx ;eax = fila * 3 
			pop ebx
			add eax,ebx ; eax =  fila * columnas + contador de posicion
			.IF(matriz2[eax*4]==esi)
				inc i
			.ENDIF
			inc ebx
			pop edx ; recupera fila
		.endw

		; Calculo de direccion de primera columna
		mov eax, edx
		mov ebx,3
		mul ebx
		mov ebx,matriz2[eax*4] ;contador de fila en columna 0
		.IF(i==0)  ;Si no hay acierto
			mov esi, direcciones[ecx*4]; guardaben esi la direccion actual
			add eax,ebx ; eax = (fila * columnas) + posicion
			.IF(matriz2[eax*4]==0)
				inc ff
			.ELSE
				inc fc
			.ENDIF
			mov matriz2[eax*4], esi ; reemplaza en la memoria la direccion
			sub eax,ebx ; eax = fila * columnas // columna cero de fila actual
			.IF (ebx == 2)
				mov matriz2[eax*4], 1
			.ELSEIF (ebx == 1)
				inc matriz2[eax*4] 
			.ENDIF
		.ELSE
			inc acierto
		.ENDIF
		inc ecx
	.endw

	;mostrar matriz 
	mov ecx,0
	mov edx,0
	mov cont,0
	.while(ecx<8)
		.while(edx<=2)
			.IF(edx==0)
				push edx
				push eax
				mov edx,OFFSET txtConjunto
				mov eax,ecx
				call writeString
				call writedec
				mov al,':'
				call writeChar
				mov al,' '
				call writeChar
				pop eax
				pop edx
			.ELSE
				push edx
				mov eax, ecx
				mov ebx, 3
				mul ebx
				pop edx
				add eax,edx
				push edx
				mov ebx,4
				mul ebx
				push eax
				mov al,'['
				call writeChar
				pop eax
				pop edx
				mov ebx, eax
				mov eax,matriz2[ebx]
				call writedec
				push eax
				mov al,']'
				call writeChar
				mov al,' '
				call writeChar
				pop eax
			.ENDIF
			inc edx
		.endw
		mov edx,0
		call crlf
		inc ecx
	.endw

;falla forzosa
	mov eax, ff
	mov edx, OFFSET txtff
	call crlf
	call writeString
	call writeDec
	call crlf
	;falla conflicto
	mov eax, fc
	mov edx, OFFSET txtfc
	call writeString
	call writeDec
	call crlf
	;fallas totals
	mov eax, ff
	add eax, fc
	mov edx, OFFSET txtft
	call writeString
	call writeDec
	call crlf

	;Tasa de fallas
	mov eax, ff
	add eax,fc
	mov ebx, 100
	mul ebx
	mov ebx,tamDir
	div ebx
	mov edx, OFFSET txttf
	call writeString
	call writeDec
	mov al,'%'
	call writeChar
	call crlf

	;Aciertos totales
	mov eax, acierto
	mov edx, OFFSET txtac
	call writeString
	call writeDec
	call crlf
	
	mov eax, acierto
	mov ebx, 100
	mul ebx
	mov ebx,tamDir
	div ebx
	mov edx, OFFSET txtta
	call writeString
	call writeDec
	mov al,'%'
	call writeChar
	call crlf
	call crlf

ret

modulo22 ENDP

modulo23 PROC
; Modulo 2 tipo 3
mov ecx,0

;columna contadores 1
mov eax,0
mov esi,0
.while(ecx<4)
	
	mov matriz3[esi],1
	add esi,20
	inc ecx
.endw


; FIFO
mov ecx,0
.while(ecx<tamdir)
		mov edx,0
		mov eax, direcciones[ecx*4]
		mov ebx, 1
		div ebx
		mov ebx, nc
		div ebx		;devuelve en edx el numero de la fila

		; Hallar aciertos
		mov i,0
		mov ebx, 1
		.while(ebx<=4)
			push edx ; guarda fila
			mov esi,direcciones[ecx*4]
			mov eax, edx ;fila
			push ebx
			mov ebx, 5 
			mul ebx ;eax = fila * 5 
			pop ebx
			add eax,ebx ; eax =  fila * columnas + contador de posicion
			.IF(matriz3[eax*4]==esi)
				inc i
			.ENDIF
			inc ebx
			pop edx ; recupera fila
		.endw

		; Calculo de direccion de primera columna
		mov eax, edx
		mov ebx,5
		mul ebx
		mov ebx,matriz3[eax*4] ;contador de fila en columna 0

		
		.IF(i==0)  ;Si no hay acierto
			
			mov esi, direcciones[ecx*4]; guardaben esi la direccion actual
			add eax,ebx ; eax = (fila * columnas) + posicion
			.IF(matriz3[eax*4]==0)
				inc ff
			.ELSE
				inc fc
			.ENDIF
			mov matriz3[eax*4], esi ; reemplaza en la memoria la direccion
			sub eax,ebx ; eax = fila * columnas // columna cero de fila actual
			.IF (ebx == 4)
				mov matriz3[eax*4], 1
			.ELSE
				inc matriz3[eax*4] 
			.ENDIF
		.ELSE
		inc acierto
		.ENDIF
		inc ecx
.endw
; mostrar matriz 
mov ecx,0
mov edx,0
mov cont,0
.while(ecx<4)
	.while(edx<=4)
		.IF(edx==0)
			push edx
			push eax
			mov edx,OFFSET txtConjunto
			mov eax,ecx
			call writeString
			call writedec
			mov al,':'
			call writeChar
			mov al,' '
			call writeChar
			pop eax
			pop edx
		.ELSE
		push edx
		mov eax, ecx
		mov ebx, 5
		mul ebx
		pop edx
		add eax,edx
		push edx
		mov ebx,4
		mul ebx
		push eax
		mov al,'['
		call writeChar
		pop eax
		pop edx
		mov ebx, eax
		mov eax,matriz3[ebx]
		call writedec
		push eax
		mov al,']'
		call writeChar
		mov al,' '
		call writeChar
		pop eax
		.ENDIF
	inc edx
	.endw
	mov edx,0
	call crlf
	inc ecx
.endw
; QUEDE AQUI
;PANCHO AQUI
;CORRIJE LAS ETIQUETAS SIGUIENDO LOS EJEMPLOS DE ARRIBA
;falla forzosa
	mov eax, ff
	mov edx, OFFSET txtff
	call crlf
	call writeString
	call writeDec
	call crlf
	;falla conflicto
	mov eax, fc
	mov edx, OFFSET txtfc
	call writeString
	call writeDec
	call crlf
	;fallas totals
	mov eax, ff
	add eax, fc
	mov edx, OFFSET txtft
	call writeString
	call writeDec
	call crlf

	;Tasa de fallas
	mov eax, ff
	add eax,fc
	mov ebx, 100
	mul ebx
	mov ebx,tamDir
	div ebx
	mov edx, OFFSET txttf
	call writeString
	call writeDec
	mov al,'%'
	call writeChar
	call crlf

	;Aciertos totales
	mov eax, acierto
	mov edx, OFFSET txtac
	call writeString
	call writeDec
	call crlf
	
	mov eax, acierto
	mov ebx, 100
	mul ebx
	mov ebx,tamDir
	div ebx
	mov edx, OFFSET txtta
	call writeString
	call writeDec
	mov al,'%'
	call writeChar
	call crlf
	call crlf

ret
modulo23 ENDP


llenadoNum PROC

mov esi,0
mov ecx,0
mov edx, OFFSET txtmsg1
call writeString
call readInt
mov tamDir,eax

.while(esi< tamDir)
mov edx, OFFSET txtmsg2
call writeString
call readInt
mov direcciones[esi*4],eax
inc esi
.endw

mov ecx,0

.while(ecx<tamDir)
		mov eax,direcciones[ecx*4]
		call writedec
		mov al," "
		call writeChar
		inc ecx
.endw
ret

llenadoNum ENDP


menu PROC
		;--------------------------------------------------------
		;MENU PRINCIPAL
		;--------------------------------------------------------
		mov edx,OFFSET msg10            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg11            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg12            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg13            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg14            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg15            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg16            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg17            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg18            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg20            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg21            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg22            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg23            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg24            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg25            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg26            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg27            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg28            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg29            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg30            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg31            ;Imprimir el texto
		call WriteString
        mov dl,93						;ubico el cursor
	    mov dh,20
	    call Gotoxy					    ;Posicionamiento
		call ReadInt					;recojo un char de pantalla
		mov opcion, eax                 ;GUARDA OPCION DEL MENU MODULO 1 o 2
		;------------------------------------------------------------
		; MODULO 1 
		;------------------------------------------------------------
		.IF(opcion==1)
		call Clrscr
		mov edx,OFFSET msg32            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg33            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg34            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg35            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg36            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg37            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg38            ;Imprimir el texto
		call WriteString
        mov dl,11						;ubico el cursor
	    mov dh,5
	    call Gotoxy					    ;Posicionamiento
		call ReadInt					;recojo un char de pantalla
		mov tipo, eax                   ;GUARDA TIPO ES DECIR DIRECTO O ASOCIATIVO
		call Clrscr
		mov edx,OFFSET msg39            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg40            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg41            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg42            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg43            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg44            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg45            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg46            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg47            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg48            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg49            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg50            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg36            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg37            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg38            ;Imprimir el texto
		call WriteString
        mov dl,11						;ubico el cursor
	    mov dh,13
	    call Gotoxy					    ;Posicionamiento
		call ReadInt					;recojo un char de pantalla
		.IF(eax==1)
		mov mp, 32768
		.ELSEIF(eax==2)
		mov mp, 65536
		.ELSEIF(eax==3)
		mov mp, 131072
		.ELSEIF(eax==4)
		mov mp, 262144
		.ELSEIF(eax==5)
		mov mp, 524288
		.ELSEIF(eax==6)
		mov mp, 1048576
		.ELSEIF(eax==7)
		mov mp, 2097152
		.ELSEIF(eax==8)
		mov mp, 4194304
		.ELSEIF(eax==9)
		mov mp, 8388608
		.ELSEIF(eax==10)
		mov mp, 16777216
		.ELSEIF(eax==11)
		mov mp, 33554432
		.ENDIF                    ;guarda variable
		call Clrscr
		mov edx,OFFSET msg51            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg52            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg53            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg54            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg55            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg56            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg36            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg37            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg38            ;Imprimir el texto
		call WriteString
        mov dl,11						;ubico el cursor
	    mov dh,7
	    call Gotoxy					    ;Posicionamiento
		call ReadInt					;recojo un char de pantalla
		.IF(eax==1)
		mov mc, 64
		.ELSEIF(eax==2)
		mov mc, 128
		.ELSEIF(eax==3)
		mov mc, 256
		.ELSEIF(eax==4)
		mov mc, 512
		.ELSEIF(eax==5)
		mov mc, 1024
		.ENDIF							;guardo lo leido en pantalla
		call Clrscr
		mov edx,OFFSET msg57            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg58            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg59            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg60            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg61            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg62            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg36            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg37            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg38            ;Imprimir el texto
		call WriteString
        mov dl,11						;ubico el cursor
	    mov dh,7
	    call Gotoxy					    ;Posicionamiento
		call ReadInt					;recojo un char de pantalla
		.IF(eax==1)
		mov tb, 2
		.ELSEIF(eax==2)
		mov tb, 4
		.ELSEIF(eax==3)
		mov tb, 8
		.ELSEIF(eax==4)
		mov tb, 16
		.ELSEIF(eax==5)
		mov tb, 32
		.ENDIF							;guardo lo leido en pantalla
		.IF(tipo==2)
		call Clrscr
		mov edx,OFFSET msg63            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg64            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg65            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg66            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg36            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg37            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg38            ;Imprimir el texto
		call WriteString
        mov dl,11						;ubico el cursor
	    mov dh,5
	    call Gotoxy					    ;Posicionamiento
		call ReadInt					;recojo un char de pantalla
		.IF(eax==1)
		mov tc, 2
		.ELSEIF(eax==2)
		mov tc, 4
		.ELSEIF(eax==3)
		mov tc, 8
		.ENDIF							;guardo lo leido en pantalla
		.ENDIF
		call Clrscr
		mov edx,OFFSET msg67            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg68            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg69            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg70            ;Imprimir el texto
        mov dl,11						;ubico el cursor
	    mov dh,2
	    call Gotoxy					    ;Posicionamiento
		call ReadInt					;recojo un char de pantalla
		mov dir, eax                 ;guardo lo leido en pantalla
		call Clrscr
		call modulo1
		call waitmsg
		call Clrscr
		call menu
		;----------------------------------------------------------------------
		;MODULO 2
		;----------------------------------------------------------------------
		.ELSEIF(opcion==2)
		call Clrscr
		call pedirDirecciones
		call Clrscr
		mov edx,OFFSET msg71            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg72            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg73            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg74            ;Imprimir el texto
		call WriteString
		mov ff,0
		mov fc,0
		mov acierto,0
		mov tb, 8
		mov nc, 8
		call crlf
		call modulo21
		call waitmsg
		call Clrscr
		call menu
		.ELSEIF(opcion==3)
		call Clrscr
		call pedirDirecciones
		call Clrscr
		mov edx,OFFSET msg75            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg76            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg73            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg74            ;Imprimir el texto
		call WriteString
		mov ff,0
		mov fc,0
		mov acierto,0
		mov tb, 16
		mov nc, 8
		call crlf
		call modulo22
		call waitmsg
		call Clrscr
		call menu
		
		.ELSEIF(opcion==4)
		call Clrscr
		call pedirDirecciones
		call Clrscr
		mov edx,OFFSET msg77            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg76            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg78            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg74            ;Imprimir el texto
		call WriteString
		mov ff,0
		mov fc,0
		mov acierto,0
		mov tb, 16
		mov nc, 4
		call crlf
		call modulo23
		call waitmsg
		call Clrscr
		call menu
		.ENDIF
		ret             

menu ENDP

pedirDirecciones PROC
	mov tamDir, 21
	.while(tamDir>20)
		mov edx,OFFSET msg79            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg68            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg69            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg70            ;Imprimir el texto
		call WriteString
		mov dl,10						;ubico el cursor
	    mov dh,2
	    call Gotoxy					    ;Posicionamiento
		call ReadInt					;recojo un char de pantalla
		mov tamDir, eax
		call crlf
		.IF(tamDir>20)
		mov edx,OFFSET msg80            ;Imprimir el texto
		call WriteString
		call Waitmsg
		call Clrscr
		.ENDIF	
	.endw
	call Clrscr
	mov ebx, 0
	mov eax, 0
	.while(ebx<tamDir)
		mov edx,OFFSET msg81            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg68            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg69            ;Imprimir el texto
		call WriteString
		mov edx,OFFSET msg70            ;Imprimir el texto
		call WriteString
		mov dl,10						;ubico el cursor
	    mov dh,2
	    call Gotoxy					    ;Posicionamiento
		call ReadInt					;recojo un char de pantalla
		mov direcciones[ebx*4], eax
		call Clrscr
		inc ebx
	.endw
	ret



pedirDirecciones ENDP




main PROC

call menu
exit
main ENDP
END main