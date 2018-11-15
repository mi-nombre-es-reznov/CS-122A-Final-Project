/*
 * CS_122A_Final_Project.c
 *
 * Created: 11/11/2018 10:27:03 AM
 * Author : xXSexybeastXx
 */ 

// Pre-processor files
#include <avr/io.h>
#define F_CPU 8000000UL
#include <util/delay.h>
#include "User_input.h"
#include "User_input.c"

// Main
int main(void) {
	
	// initialize ports
	DDRB = 0xFF; PORTB = 0x00;
	DDRA = 0x00; PORTA = 0xFF;
	DDRC = 0x00; PORTC = 0xFF;
	initUSART(0);
	USART_Flush(0);

	while(1) 
	{
		input_detector();
		_delay_ms(100);
	}
}
