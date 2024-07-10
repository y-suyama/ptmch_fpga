/********************************************************************************//*!
 * @file  mem_util.h
 * @brief  Memory utility headder file.
 *
 * @details  Memory utility headder file.
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
extern void sample_memset_address32(uint32_t* start, size_t size);
extern void sample_memset_incrementdata(uint32_t* start, uint32_t testdata, size_t size);
extern void sample_memset_incrementdata_4byte(uint32_t* start, uint32_t testdata, size_t size);
extern void sample_memdmp_word(const uint32_t* start, size_t size);
extern void sample_memdmp_halfword(const uint16_t* start, size_t size);
extern void sample_memdmp_byte(const uint8_t* start, size_t size);
