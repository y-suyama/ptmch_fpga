/*
 /**************************************************************************
*  Company name        :
*  Date                :
*  File Name           : cmd.c
*  Project Name        :
*  Coding              : suyama
*  Rev.                : 1.0
*
***************************************************************************
* includes
***************************************************************************/
/* Standard Headers */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/* Lib Headers */
//#include "system.h"
#include "alt_types.h"
//#include "io.h"

/* User Headers */
#include "cmd.h"
#include "mem_util.h"

//extern int sample_dmac_test_cmd(char* options);
//extern int sample_dma_mem_test_cmd(char* options);
//extern int sample_cache_manage_test_cmd(char* options);
//extern int sample_clkmgr_test_cmd(char* options);
//extern int sample_ecc_test_cmd(char* options);
//extern int sample_globaltmr_test_cmd(char* options);
#ifdef soc_cv_av
//extern int sample_gpio_test_cmd(char* options);
#endif /* soc_cv_av */
//extern int sample_gptmr_test_cmd(char* options);
//extern int sample_intctrl_test_cmd(char* options);
//extern int sample_mmu_test_cmd(char* options);
//extern int sample_time_measurement_test_cmd(char* options);
//extern int sample_wdog_test_cmd(char* options);

COMMANDS_LIST commands[] = {
	{"menu",    "Print of menu",                                                cmd_menu},
	{"mr",      "mr <type:8/16/32> <addr(HEX)> ",                               cmd_mem_read},
	{"mw",      "mw <type:8/16/32> <addr(HEX)> <data(HEX)>",                    cmd_mem_write},
	{"md",      "md <type:8/16/32> <addr(HEX)> <size(HEX)>",                    cmd_mem_dump},
	{"mf",      "mf <type(0:inc/1:fixed> <data(HEX)> <addr(HEX)> <size(HEX)>",  cmd_mem_fill},
//	{"dma",     "dma <src(HEX)> <dst(HEX)> <size(HEX)> <bytes(1/2/4/8)>",       sample_dmac_test_cmd},
//	{"dmamem",  "HPS internal DMA (DMA-330) example program",                   sample_dma_mem_test_cmd},
//	{"cache",   "Cache Management example program",                             sample_cache_manage_test_cmd},
//	{"clk",     "Clock Manager example program",                                sample_clkmgr_test_cmd},
//	{"ecc",     "ECC Management example program",                               sample_ecc_test_cmd},
//	{"gltmr",   "Global Timer example program",                                 sample_globaltmr_test_cmd},
#ifdef soc_cv_av
//	{"gpio",    "General Purpose I/O example program",                          sample_gpio_test_cmd},
#endif /* soc_cv_av */
//	{"gptmr",   "General-Purpose Timer example program",                        sample_gptmr_test_cmd},
//	{"intctrl", "Interrupt Controller (mainly SGI) example program",            sample_intctrl_test_cmd},
//	{"mmu",     "MMU Management example program",                               sample_mmu_test_cmd},
//	{"time",    "Time measurement example program",                             sample_time_measurement_test_cmd},
//	{"wdog",    "Watchdog timer (and reset manager) example program",           sample_wdog_test_cmd},
	{"exit",    "Exit",                                                         cmd_exit},
	{0, 0, cmd_dummy}
};

int cmd_menu(char* options)
{
	int i;

	for(i = 0; commands[i].name; i++)  {
		printf(" %-10s:\t%s\n",commands[i].name, commands[i].usage);
	}
	printf(" * Note: HEX Value does not need 0x \n");

	return 0;
}

static void remove_nonascii(char* target_str, int sizeof_str)
{
	char* current_p;
	char* removed_p;
	int i;

	current_p = target_str;
	removed_p = target_str;

	// BackSpace('\b')
	for(i=0; i<sizeof_str; i++){
		if(*current_p == '\0')	break;
		else if((*current_p < ' ')||('~' < *current_p)){
			if(*current_p == '\b'){
				removed_p--;
				if((uint32_t)removed_p < (uint32_t)target_str)	removed_p = target_str;
			}
			current_p++;
		} else {
			*removed_p++ = *current_p++;
		}
	}
	*removed_p = '\0';
}

int cmd_execute(void)
{
	int result = 0;
	int i;
	char input_str[128];

	printf("\n");
	printf("Command: ");
	fflush(stdout);

	fgets(input_str, sizeof(input_str), stdin);
	remove_nonascii(input_str, strlen(input_str));
	printf("%s\n", input_str);
	fflush(stdout);

	for(i = 0; commands[i].name; i++) {
		/* parse cmd */
		if(strstr(input_str, commands[i].name) != NULL) {
			/* Execute Command */
			result = commands[i].func(input_str + strlen(commands[i].name));
			if(result != 0)	{ printf("Exit loop \n"); break; } //Exit loop
		}
	}

	return result;
}

int cmd_dummy(char* options)
{
	return 0;
}

int cmd_exit(char* options)
{
	return 1;
}

int cmd_mem_read(char* options)
{
	int type;
	alt_u32 addr;
	alt_u32 read_data;

	printf("mem_read \n");

	if( sscanf(options,"%d %lx", &type, &addr) < 2)	{
		printf("arg error \n");
		return 0;
	}

	switch(type){
	case 8:
		read_data = IORD_8DIRECT(addr, 0);
		printf("read_data = %02lx \n",read_data);
		break;
	case 16:
		read_data = IORD_16DIRECT(addr, 0);
		printf("read_data = %04lx \n",read_data);
		break;
	case 32:
		read_data = IORD_32DIRECT(addr, 0);
		printf("read_data = %08lx \n",read_data);
		break;
	default:
		printf("Specified type is not supported \n");
		return 0;
	}

	return 0;
}

int cmd_mem_write(char* options)
{
	int type;
	alt_u32 addr;
	alt_u32 data;

	printf("mem_write \n");

	if( sscanf(options,"%d %lx %lx", &type, &addr, &data) < 3) {
		printf("arg error \n");
		return 0;
	}

	switch(type){
	case 8:
		IOWR_8DIRECT(addr, 0, data);
		break;
	case 16:
		IOWR_16DIRECT(addr, 0, data);
		break;
	case 32:
		IOWR_32DIRECT(addr, 0, data);
		break;
	default:
		printf("Specified type is not supported \n");
		return 0;
	}

	return 0;
}

int cmd_mem_dump(char* options)
{
	int type;
	alt_u32 addr;
	alt_u32 size;

	printf("mem_dump \n");

	if( sscanf(options,"%d %lx %lx", &type, &addr, &size) < 3) {
		printf("arg error \n");
		return 0;
	}

	printf("base_addr = %08lx \n",addr);

	switch(type){
	case 8:
		sample_memdmp_byte((uint8_t*)addr, size);
		break;
	case 16:
		sample_memdmp_halfword((uint16_t*)addr, size);
		break;
	case 32:
		sample_memdmp_word((uint32_t*)addr, size);
		break;
	default:
		printf("Specified type is not supported \n");
		return 0;
	}

	return 0;
}

int cmd_mem_fill(char* options)
{
	int i;
	int type;
	alt_u32 data;
	alt_u32 addr;
	alt_u32 size;

	printf("mem_fill \n");

	if( sscanf(options,"%d %lx %lx %lx", &type, &data, &addr, &size) < 4) {
		printf("arg error \n");
		return 0;
	}

	switch(type){
	case 0: //increment
		printf(" Fill incremental data from addr:0x%08x (size:0x%x) data_start:0x%02x  \n", (int)addr, (int)size, (int)data);
		for(i=0; i < size; i++){
			IOWR_8DIRECT(addr, i, data+i);
		}
		break;
	case 1: //Fixed
		printf(" Fill fixed data from addr:0x%08x (size:0x%x) data:0x%02x  \n", (int)addr, (int)size, (int)data);
		for(i=0; i < size; i++){
			IOWR_8DIRECT(addr, i, data);
		}
		break;
	default:
		printf(" Specified type is not supported \n");
		printf(" type: 0:increment / 1: fixed \n");
		break;
	}

	return 0;
}
/***********************************************************************************
 * end of file
 ***********************************************************************************/


