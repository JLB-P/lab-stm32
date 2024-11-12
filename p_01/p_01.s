;directivas de ensamblador
;-------------------------
			area constantes, data, readonly 	;area de código de solo lectura	
RCC_APB2ENR equ	0x40021018						;registro reloj de puertos
GPIOC_CRL	equ	0x40011000						;registro para configuración de puerto C (parte baja)
GPIOC_CRH	equ	0x40011004						;registro para configuración de puerto C (parte alta)
GPIOC_ODR	equ 0x4001100C	
	
;area de programa
			area p_01, code, readonly 	; area de código de solo lectura
			export __main				; se exporta a startup_stm32f10x_md.s
;inicio del programa
;-------------------
__main
	ldr r0, =0x00000010		;r0 valor para habilitar reloj de puerto C (bit4=1)
	ldr r1, =RCC_APB2ENR	;r1 apunta al registro de reloj de puertos
	str r0, [r1]			;almacena '1' en el bit 4 del registro
	
	ldr r0,=0x44444444		;r0 valor para reset
	ldr r1,=GPIOC_CRL
	str r0,[r1]				;reset al puerto
	
	ldr r0,=0x44344444		;r0 valor para reset
	ldr r1,=GPIOC_CRH
	str r0,[r1]				;reset al puerto
ciclo	
	ldr r0,=0x00002000		;r0 valor para reset
	ldr r1,=GPIOC_ODR
	str r0,[r1]				;reset al puerto
	
	ldr r0,=0x00000000		;r0 valor para reset
	ldr r1,=GPIOC_ODR
	str r0,[r1]				;reset al puerto
	
	b ciclo		; ciclo infinito
;fin del programa
;----------------
	end	