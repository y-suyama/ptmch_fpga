/********************************************************************************//*!
 * @file  cmd.h
 * @brief  Command utility headder file.
 *
 * @details  Command utility headder file.
 *
 * @note  nothing.
 *
 * @attention
 * Copyright (C) 2013-2019 MACNICA,Inc. All Rights Reserved.\n
 *   This software is licensed "AS IS".
 *   Please perform use of this software by a user's own responsibility and expense.
 *   It cannot guarantee in the maker side about the damage which occurred by the ab-
 *   ility not to use or use this software, and all damage that occurred secondarily.
 **//*******************************************************************************/
#ifndef SOC_HWLIB_SAMPLE_CMD_H_
#define SOC_HWLIB_SAMPLE_CMD_H_

/* Standard Headers */
#include <stdio.h>
#include <string.h>

/* NiosII Headers */
#include "alt_types.h"

/* User Headers */

typedef struct command {
	char* name;
	char* usage;
	int (*func)(char* options);
} COMMANDS_LIST;


/* Function Prototype */
int cmd_execute(void);

int cmd_dummy(char* options);
int cmd_menu(char* options);
int cmd_exit(char* options);

int cmd_mem_read(char* options);
int cmd_mem_write(char* options);
int cmd_mem_dump(char* options);
int cmd_mem_fill(char* options);
#endif /* SOC_HWLIB_SAMPLE_CMD_H_ */
