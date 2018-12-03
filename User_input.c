/*
 * User_Input.c
 *
 * Created: 11/11/2018 10:27:03 AM
 * Author : xXSexybeastXx
 */ 

// Pre-processor files
#include "User_input.h"
#include "usart_ATmega1284.h"
#include <stdio.h>

// Variables
unsigned char seat_1, seat_2, seat_3, seat_4, seat_5, seat_6;
unsigned char belt_1, belt_2, belt_3, belt_4, belt_5, belt_6;
unsigned int finish, flash_flag = 0, count = 0;
unsigned short adc_val;

// Enumerated states
enum ID_States {ID_SMStart, ID_Init, ID_assign_values} ID_state;
enum SL_States {SL_Init, SL_Lights} SL_state;
		
// Call Functions
void input_detector()
{
	switch(ID_state)
	{
		case ID_SMStart:
		{
			ID_state = ID_Init;
			break;
		}
		case ID_Init:
		{
			ID_state = ID_assign_values;
			break;
		}
		case ID_assign_values:
		{
			if((~PINA & 0x01) == 0x01)
			{
				seat_1 = 1;
			}
			else
			{
				seat_1 = 0;
			}
			
			if((~PINA & 0x02) == 0x02)
			{
				seat_2 = 1;
			}
			else
			{
				seat_2 = 0;
			}
			
			if((~PINA & 0x04) == 0x04)
			{
				seat_3 = 1;
			}
			else
			{
				seat_3 = 0;
			}
			
			if((~PINA & 0x08) == 0x08)
			{
				seat_4 = 1;
			}
			else
			{
				seat_4 = 0;
			}
			
			if((~PINA & 0x10) == 0x10)
			{
				seat_5 = 1;
			}
			else
			{
				seat_5 = 0;
			}
			
			if((~PINA & 0x20) == 0x20)
			{
				seat_6 = 1;
			}
			else
			{
				seat_6 = 0;
			}
			
			if((~PINC & 0x01) == 0x01)
			{
				belt_1 = 1;
			}
			else
			{
				belt_1 = 0;
			}
			
			if((~PINC & 0x02) == 0x02)
			{
				belt_2 = 1;
			}
			else
			{
				belt_2 = 0;
			}
			
			if((~PINC & 0x04) == 0x04)
			{
				belt_3 = 1;
			}
			else
			{
				belt_3 = 0;
			}
			
			if((~PINC & 0x08) == 0x08)
			{
				belt_4 = 1;
			}
			else
			{
				belt_4 = 0;
			}
			
			if((~PINC & 0x10) == 0x10)
			{
				belt_5 = 1;
			}
			else
			{
				belt_5 = 0;
			}
			
			if((~PINC & 0x20) == 0x20)
			{
				belt_6 = 1;
			}
			else
			{
				belt_6 = 0;
			}			
			
			ID_state = ID_assign_values;
			break;
		}
		default:
			break;
	}
	
	switch(ID_state)
	{
		case ID_SMStart:
			break;
		case ID_Init:
		{
			seat_1 = 0;
			seat_2 = 0;
			seat_3 = 0;
			seat_4 = 0;
			seat_5 = 0;
			seat_6 = 0;
			belt_1 = 0;
			belt_2 = 0;
			belt_3 = 0;
			belt_4 = 0;
			belt_5 = 0;
			belt_6 = 0;
			count = 0;
			
			break;
		}
		case ID_assign_values:
		{
			// Contemplate making flags to send in the same data to distinguish between what works and what doesn't.
			// May need one to tell if both == 1 or if 1 == 1.
			if((seat_1 == 1) && (belt_1 == 1) || (seat_1 == 0) && (belt_1 == 1) || (seat_1 == 0) && (belt_1 == 0))
			{
				// Cannot be turned off. Must have seatbelt on if weight is detected.
				PORTB |= 0x01;
				
				if(USART_IsSendReady(0))
				{
					USART_Send(0x01, 0);
				}
		
				while(!USART_HasTransmitted(0));
				_delay_ms(100);	
			}
			else
			{
				// Can be turned off.
				PORTB &= 0xFE;
				
				/*if((seat_1 == 1) && (belt_1 == 0))
				{
					PORTB |= 0xC0;
					_delay_ms(300);
					PORTB &= 0x3F;
					_delay_ms(300);
				}*/
				
				if(USART_IsSendReady(0))
				{
					USART_Send(0x81, 0);
				}
		
				while(!USART_HasTransmitted(0));
				_delay_ms(100);	
			}
			
			if((seat_2 == 1) && (belt_2 == 1) || (seat_2 == 0) && (belt_2 == 1) || (seat_2 == 0) && (belt_2 == 0))
			{
				// Can be turned off.
				PORTB |= 0x02;
	
				if(USART_IsSendReady(0))
				{
					USART_Send(0x02, 0);
				}
				
				while(!USART_HasTransmitted(0));
				_delay_ms(100);
			}
			else
			{
				// Can be turned off.
				PORTB &= 0xFD;
				
				/*if((seat_2 == 1) && (belt_2 == 0))
				{
					PORTB |= 0xC0;
					_delay_ms(300);
					PORTB &= 0x3F;
					_delay_ms(300);
				}*/
				
				if(USART_IsSendReady(0))
				{
					USART_Send(0x82, 0);
				}
				
				while(!USART_HasTransmitted(0));
				_delay_ms(100);
			}	
			
			if((seat_3 == 1) && (belt_3 == 1) || (seat_3 == 0) && (belt_3 == 1) || (seat_3 == 0) && (belt_3 == 0))
			{
				// Can be turned off.
				PORTB |= 0x04;
				
				if(USART_IsSendReady(0))
				{
					USART_Send(0x04, 0);
				}
				
				while(!USART_HasTransmitted(0));
				_delay_ms(100);
			}
			else
			{
				// Can be turned off.
				PORTB &= 0xFB;
				
				/*if((seat_3 == 1) && (belt_3 == 0))
				{
					PORTB |= 0xC0;
					_delay_ms(300);
					PORTB &= 0x3F;
					_delay_ms(300);
				}*/
				
				if(USART_IsSendReady(0))
				{
					USART_Send(0x84, 0);
				}
				
				while(!USART_HasTransmitted(0));
				_delay_ms(100);
			}
			
			if((seat_4 == 1) && (belt_4 == 1) || (seat_4 == 0) && (belt_4 == 1) || (seat_4 == 0) && (belt_4 == 0))
			{
				// Can be turned off.
				PORTB |= 0x08;
			
				if(USART_IsSendReady(0))
				{
					USART_Send(0x08, 0);
				}
				
				while(!USART_HasTransmitted(0));
				_delay_ms(100);
			}
			else
			{
				// Can be turned off.
				PORTB &= 0xF7;
				
				/*if((seat_4 == 1) && (belt_4 == 0))
				{
					PORTB |= 0xC0;
					_delay_ms(300);
					PORTB &= 0x3F;
					_delay_ms(300);
				}*/
				
				if(USART_IsSendReady(0))
				{
					USART_Send(0x88, 0);
				}
				
				while(!USART_HasTransmitted(0));
				_delay_ms(100);
			}
			
			if((seat_5 == 1) && (belt_5 == 1) || (seat_5 == 0) && (belt_5 == 1) || (seat_5 == 0) && (belt_5 == 0))
			{
				// Can be turned off.
				PORTB |= 0x10;
				
				if(USART_IsSendReady(0))
				{
					USART_Send(0x10, 0);
				}
				
				while(!USART_HasTransmitted(0));
				_delay_ms(100);
			}
			else
			{
				PORTB &= 0xEF;
				
				/*if((seat_5 == 1) && (belt_5 == 0))
				{
					PORTB |= 0xC0;
					_delay_ms(300);
					PORTB &= 0x3F;
					_delay_ms(300);
				}*/
				
				if(USART_IsSendReady(0))
				{
					USART_Send(0x90, 0);
				}
				
				while(!USART_HasTransmitted(0));
				_delay_ms(100);
			}
			
			if((seat_6 == 1) && (belt_6 == 1) || (seat_6 == 0) && (belt_6 == 1) || (seat_6 == 0) && (belt_6 == 0))
			{
				// Can be turned off.
				PORTB |= 0x20;
				
				if(USART_IsSendReady(0))
				{
					USART_Send(0x20, 0);
				}
				
				while(!USART_HasTransmitted(0));
				_delay_ms(100);
			}
			else
			{
				PORTB &= 0xDF;
				
				/*if((seat_6 == 1) && (belt_6 == 0))
				{
					PORTB |= 0xC0;
					_delay_ms(300);
					PORTB &= 0x3F;
					_delay_ms(300);
				}*/
				
				if(USART_IsSendReady(0))
				{
					USART_Send(0xA0, 0);
				}
				
				while(!USART_HasTransmitted(0));
				_delay_ms(100);		
			}
			
			
			if((seat_1 == 1) && (belt_1 == 0) || (seat_2 == 1) && (belt_2 == 0) || (seat_3 == 1) && (belt_3 == 0) || (seat_4 == 1) && (belt_4 == 0) || (seat_5 == 1) && (belt_5 == 0) || (seat_6 == 1) && (belt_6 == 0))
			{
				if(count >= 20)
				{
					PORTB |= 0xC0;
					_delay_ms(300);
					PORTB &= 0x3F;
					_delay_ms(300);
				}
			}
			else
			{
				count = 0;
			}
			
			count++;
			
			break;
		}
		default:
		{
			PORTB = 0xFF;
			break;
		}
	}
}