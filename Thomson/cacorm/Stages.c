#include "Stage.h"
#include "Stages.h"

static const byte[] Items0 = {
	(1 << 4) | 1,
	(14 << 4) | 7,
	(11 << 4) | 8,
	(5 << 4) | 9,
};

static const byte[] Enemies0 = {
	(14 << 4) | 3,
};

static const byte[] Items1 = {
	(7 << 4) | 2,
	(14 << 4) | 2,
	(11 << 4) | 4,
	(3 << 4) | 8,
	(12 << 4) | 9,
};

static const byte[] Enemies1 = {
	(8 << 4) | 1,
};

static const byte[] Items2 = {
	(14 << 4) | 3,
	(2 << 4) | 4,
	(7 << 4) | 4,
	(4 << 4) | 9,
};

static const byte[] Enemies2 = {
	(14 << 4) | 7,
};

static const byte[] Items3 = {
	(4 << 4) | 1,
	(2 << 4) | 4,
	(6 << 4) | 4,
	(14 << 4) | 7,
	(13 << 4) | 8,
};

static const byte[] Enemies3 = {
	(3 << 4) | 0,
	(1 << 4) | 10,
};

static const byte[] Items4 = {
	(1 << 4) | 1,
	(11 << 4) | 1,
	(12 << 4) | 4,
	(10 << 4) | 5,
	(11 << 4) | 6,
	(2 << 4) | 9,
};

static const byte[] Enemies4 = {
	(15 << 4) | 1,
	(15 << 4) | 10,
};

static const byte[] Items5 = {
	(8 << 4) | 3,
	(1 << 4) | 7,
	(4 << 4) | 7,
	(14 << 4) | 7,
	(4 << 4) | 9,
	(10 << 4) | 9,
};

static const byte[] Enemies5 = {
	(14 << 4) | 1,
	(2 << 4) | 9,
};

static const byte[] Items6 = {
	(12 << 4) | 1,
	(4 << 4) | 2,
	(12 << 4) | 5,
	(7 << 4) | 7,
	(1 << 4) | 8,
	(2 << 4) | 8,
};

static const byte[] Enemies6 = {
	(13 << 4) | 0,
	(1 << 4) | 2,
	(3 << 4) | 7,
};

static const byte[] Items7 = {
	(9 << 4) | 2,
	(10 << 4) | 2,
	(3 << 4) | 3,
	(2 << 4) | 5,
	(4 << 4) | 6,
	(5 << 4) | 6,
	(12 << 4) | 8,
};

static const byte[] Enemies7 = {
	(1 << 4) | 0,
	(15 << 4) | 0,
	(2 << 4) | 10,
};

static const byte[] Items8 = {
	(8 << 4) | 3,
	(9 << 4) | 3,
	(4 << 4) | 7,
	(5 << 4) | 7,
	(11 << 4) | 7,
	(13 << 4) | 8,
	(7 << 4) | 9,
	(9 << 4) | 9,
};

static const byte[] Enemies8 = {
	(0 << 4) | 0,
	(0 << 4) | 10,
	(15 << 4) | 10,
};

static const byte[] Items9 = {
	(1 << 4) | 1,
	(2 << 4) | 2,
	(9 << 4) | 3,
	(7 << 4) | 5,
	(9 << 4) | 8,
	(11 << 4) | 8,
	(1 << 4) | 9,
	(4 << 4) | 9,
};

static const byte[] Enemies9 = {
	(0 << 4) | 0,
	(7 << 4) | 0,
	(15 << 4) | 0,
	(9 << 4) | 10,
};

const Stage[] Stages = {
	{
		(8 << 4) | 6,
		4, Items0,
		1, Enemies0,
		{
			0x00, 0x06, 
			0x80, 0x40, 
			0x98, 0x32, 
			0x18, 0x02, 
			0x00, 0x08, 
			0xc0, 0x12, 
			0x00, 0x02, 
			0x08, 0x03, 
			0x88, 0x03, 
			0x80, 0x03, 
			0x00, 0x00, 
		},
	},
	{
		(8 << 4) | 8,
		5, Items1,
		1, Enemies1,
		{
			0x00, 0x00, 
			0x62, 0x10, 
			0x0a, 0x04, 
			0x00, 0x20, 
			0xd8, 0x20, 
			0xc0, 0x02, 
			0x18, 0x12, 
			0x80, 0x52, 
			0x00, 0x40, 
			0x60, 0x02, 
			0x00, 0x00, 
		},
	},
	{
		(2 << 4) | 2,
		4, Items2,
		1, Enemies2,
		{
			0x07, 0x80, 
			0x80, 0x21, 
			0x80, 0x01, 
			0x00, 0x00, 
			0x31, 0x00, 
			0x00, 0x40, 
			0x3c, 0x00, 
			0x24, 0x14, 
			0x84, 0x04, 
			0x80, 0x83, 
			0x83, 0x03, 
		},
	},
	{
		(15 << 4) | 10,
		5, Items3,
		2, Enemies3,
		{
			0x00, 0x18, 
			0x08, 0x00, 
			0x62, 0x02, 
			0x08, 0x00, 
			0x02, 0x10, 
			0x20, 0x90, 
			0x85, 0x18, 
			0x30, 0x08, 
			0x82, 0x01, 
			0x12, 0x00, 
			0x10, 0x04, 
		},
	},
	{
		(7 << 4) | 7,
		6, Items4,
		2, Enemies4,
		{
			0x00, 0xa0, 
			0x08, 0x01, 
			0x40, 0x00, 
			0x40, 0x05, 
			0x00, 0x01, 
			0x21, 0x01, 
			0x31, 0x20, 
			0x20, 0x21, 
			0x00, 0x0c, 
			0x40, 0x00, 
			0x40, 0x00, 
		},
	},
	{
		(7 << 4) | 6,
		6, Items5,
		2, Enemies5,
		{
			0x01, 0x02, 
			0x01, 0x00, 
			0x80, 0x00, 
			0x80, 0x00, 
			0x00, 0x02, 
			0x08, 0x22, 
			0x00, 0x18, 
			0x00, 0x10, 
			0x00, 0x40, 
			0x00, 0x00, 
			0x00, 0x01, 
		},
	},
	{
		(13 << 4) | 9,
		6, Items6,
		3, Enemies6,
		{
			0x00, 0x00, 
			0x00, 0x20, 
			0x01, 0x20, 
			0x00, 0x20, 
			0x00, 0x04, 
			0x13, 0x00, 
			0x18, 0x58, 
			0x30, 0x00, 
			0x10, 0x00, 
			0x00, 0x00, 
			0x30, 0x40, 
		},
	},
	{
		(12 << 4) | 6,
		7, Items7,
		3, Enemies7,
		{
			0x00, 0x00, 
			0x00, 0x00, 
			0x00, 0x00, 
			0x00, 0x00, 
			0x00, 0x40, 
			0x00, 0x00, 
			0x00, 0x00, 
			0x00, 0x01, 
			0x02, 0x02, 
			0x00, 0x4a, 
			0x00, 0x00, 
		},
	},
	{
		(15 << 4) | 2,
		8, Items8,
		3, Enemies8,
		{
			0x00, 0x00, 
			0x0c, 0x00, 
			0x00, 0x00, 
			0x10, 0x00, 
			0x10, 0x00, 
			0x00, 0x0e, 
			0x00, 0x00, 
			0x06, 0x00, 
			0x00, 0x00, 
			0x00, 0x00, 
			0x00, 0x00, 
		},
	},
	{
		(8 << 4) | 5,
		8, Items9,
		4, Enemies9,
		{
			0x00, 0x00, 
			0x40, 0x00, 
			0x40, 0x00, 
			0x00, 0x00, 
			0x00, 0x00, 
			0x00, 0x40, 
			0x00, 0x00, 
			0x00, 0x10, 
			0x00, 0x00, 
			0x00, 0x00, 
			0x00, 0x00, 
		},
	},
};