/**************************************************************************
*  Company name        :
*  Date                :
*  File Name           : main.c
*  Project Name        :
*  Coding              : suyama
*  Rev.                : 1.0
*
***************************************************************************
* includes
***************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>
#include <string.h>
/***********************************************************************************
 *  externs
 ***********************************************************************************/

/***********************************************************************************
 *  define
 ***********************************************************************************/

/***********************************************************************************
 *  proto types
 ***********************************************************************************/
extern void power_on_message(void);

/***********************************************************************************
 *  main loop
 ***********************************************************************************/
int main(void)
{
	unsigned long regval;
	char onechar;

    while (1) {
	    onechar = alt_getchar();
	    if(onechar == 'p') { // product name
	    	alt_putstr("mokemokemomomo!!!\n");
	    }
    }

	return 0;
	power_on_message();

	return 0;
}

/***********************************************************************************
 *  common Function
 ***********************************************************************************/
void power_on_message(void)
{
	printf("\n");
	printf("+-<< MAX10 suyama FW Ver.0001 >>----------------------------------+\n");
	printf("< Command Mode >\n");
	cmd_menu(NULL);
	printf("+----------------------------------------------------------------------------+\n\n");

	return;
}
/***********************************************************************************
 * end of file
 ***********************************************************************************/
