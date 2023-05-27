#include "Stage.h"
#include "Stages.h"
static const CardPosition[] Cards0 = {
	{ 1, (0 << 4) | 2 },
	{ 1, (9 << 4) | 2 },
	{ 13, (0 << 4) | 5 },
	{ 13, (9 << 4) | 6 },
};
static const byte[] Monsters0 = {
	(9 << 4) | 0,
};
static const CardPosition[] Cards1 = {
	{ 1, (4 << 4) | 1 },
	{ 12, (0 << 4) | 3 },
	{ 12, (9 << 4) | 3 },
	{ 13, (8 << 4) | 5 },
	{ 13, (0 << 4) | 6 },
	{ 1, (9 << 4) | 6 },
};
static const byte[] Monsters1 = {
	(9 << 4) | 0,
};
static const CardPosition[] Cards2 = {
	{ 13, (1 << 4) | 0 },
	{ 1, (4 << 4) | 1 },
	{ 1, (9 << 4) | 1 },
	{ 11, (3 << 4) | 3 },
	{ 12, (9 << 4) | 3 },
	{ 12, (0 << 4) | 5 },
	{ 11, (5 << 4) | 5 },
	{ 13, (9 << 4) | 6 },
};
static const byte[] Monsters2 = {
	(9 << 4) | 5,
};
static const CardPosition[] Cards3 = {
	{ 1, (9 << 4) | 0 },
	{ 13, (0 << 4) | 1 },
	{ 1, (2 << 4) | 1 },
	{ 11, (5 << 4) | 1 },
	{ 12, (1 << 4) | 2 },
	{ 7, (4 << 4) | 3 },
	{ 7, (0 << 4) | 4 },
	{ 11, (4 << 4) | 5 },
	{ 12, (2 << 4) | 6 },
	{ 13, (9 << 4) | 6 },
};
static const byte[] Monsters3 = {
	(8 << 4) | 4,
};
static const CardPosition[] Cards4 = {
	{ 1, (3 << 4) | 0 },
	{ 13, (2 << 4) | 2 },
	{ 13, (0 << 4) | 6 },
	{ 1, (9 << 4) | 6 },
};
static const byte[] Monsters4 = {
	(9 << 4) | 0,
	(4 << 4) | 1,
	(9 << 4) | 3,
	(6 << 4) | 6,
};
static const CardPosition[] Cards5 = {
	{ 12, (2 << 4) | 0 },
	{ 11, (5 << 4) | 0 },
	{ 12, (9 << 4) | 0 },
	{ 1, (0 << 4) | 1 },
	{ 13, (8 << 4) | 1 },
	{ 2, (1 << 4) | 2 },
	{ 1, (7 << 4) | 3 },
	{ 2, (7 << 4) | 4 },
	{ 11, (6 << 4) | 5 },
	{ 13, (0 << 4) | 6 },
};
static const byte[] Monsters5 = {
	(9 << 4) | 6,
};
static const CardPosition[] Cards6 = {
	{ 2, (2 << 4) | 0 },
	{ 13, (4 << 4) | 0 },
	{ 1, (9 << 4) | 0 },
	{ 12, (1 << 4) | 1 },
	{ 11, (5 << 4) | 1 },
	{ 1, (1 << 4) | 2 },
	{ 7, (6 << 4) | 2 },
	{ 7, (2 << 4) | 4 },
	{ 2, (8 << 4) | 4 },
	{ 12, (2 << 4) | 6 },
	{ 13, (7 << 4) | 6 },
	{ 11, (9 << 4) | 6 },
};
static const byte[] Monsters6 = {
	(8 << 4) | 2,
};
static const CardPosition[] Cards7 = {
	{ 2, (1 << 4) | 0 },
	{ 12, (3 << 4) | 0 },
	{ 11, (5 << 4) | 0 },
	{ 13, (7 << 4) | 0 },
	{ 1, (1 << 4) | 1 },
	{ 1, (1 << 4) | 2 },
	{ 3, (2 << 4) | 2 },
	{ 9, (3 << 4) | 4 },
	{ 9, (9 << 4) | 4 },
	{ 3, (2 << 4) | 5 },
	{ 2, (8 << 4) | 5 },
	{ 11, (0 << 4) | 6 },
	{ 12, (6 << 4) | 6 },
	{ 13, (9 << 4) | 6 },
};
static const byte[] Monsters7 = {
	(9 << 4) | 0,
	(8 << 4) | 6,
};
static const CardPosition[] Cards8 = {
	{ 13, (2 << 4) | 0 },
	{ 7, (5 << 4) | 0 },
	{ 12, (8 << 4) | 0 },
	{ 1, (1 << 4) | 1 },
	{ 2, (3 << 4) | 1 },
	{ 3, (6 << 4) | 1 },
	{ 9, (3 << 4) | 2 },
	{ 11, (4 << 4) | 2 },
	{ 12, (1 << 4) | 3 },
	{ 9, (1 << 4) | 4 },
	{ 7, (4 << 4) | 4 },
	{ 2, (8 << 4) | 4 },
	{ 3, (4 << 4) | 5 },
	{ 11, (8 << 4) | 5 },
	{ 1, (1 << 4) | 6 },
	{ 13, (4 << 4) | 6 },
};
static const byte[] Monsters8 = {
	(9 << 4) | 0,
	(9 << 4) | 6,
};
static const CardPosition[] Cards9 = {
	{ 9, (3 << 4) | 0 },
	{ 12, (1 << 4) | 1 },
	{ 1, (2 << 4) | 1 },
	{ 6, (4 << 4) | 1 },
	{ 3, (5 << 4) | 1 },
	{ 11, (7 << 4) | 1 },
	{ 5, (0 << 4) | 2 },
	{ 2, (2 << 4) | 2 },
	{ 8, (7 << 4) | 2 },
	{ 4, (9 << 4) | 2 },
	{ 11, (0 << 4) | 3 },
	{ 4, (1 << 4) | 3 },
	{ 8, (3 << 4) | 3 },
	{ 13, (5 << 4) | 3 },
	{ 7, (6 << 4) | 3 },
	{ 3, (2 << 4) | 4 },
	{ 13, (8 << 4) | 4 },
	{ 5, (9 << 4) | 4 },
	{ 12, (1 << 4) | 5 },
	{ 2, (3 << 4) | 5 },
	{ 1, (5 << 4) | 5 },
	{ 6, (8 << 4) | 5 },
	{ 7, (2 << 4) | 6 },
	{ 9, (7 << 4) | 6 },
};
static const byte[] Monsters9 = {
	(9 << 4) | 0,
	(9 << 4) | 6,
};
const Stage[] Stages = {
	
{ { 0x00, 0xea, 0x07, 0xa0, 0x7d, 0x00, 0xba, 0x07, 0xa0, 0x77, 0x00, 0xfa, 0x06, 0xa0, 0x5f, 0x00, 0xfe, 0x0f, }, (0 << 4) | 0, 4, Cards0, 1, Monsters0},
	
{ { 0x31, 0x2b, 0x02, 0xa0, 0x9b, 0xc8, 0xda, 0x08, 0xa2, 0xe1, 0x38, 0x16, 0x26, 0x60, 0xbb, 0x00, 0xfe, 0x0f, }, (0 << 4) | 0, 6, Cards1, 1, Monsters1},
	
{ { 0x01, 0xd3, 0x23, 0xa0, 0xbb, 0x08, 0x9a, 0x2a, 0x64, 0xcd, 0xca, 0xa2, 0x14, 0x24, 0xcc, 0x26, 0xfe, 0x0f, }, (0 << 4) | 0, 8, Cards2, 1, Monsters2},
	
{ { 0x00, 0x56, 0x27, 0x62, 0xd6, 0x12, 0xda, 0x0e, 0xa0, 0x66, 0x68, 0x96, 0x24, 0xa8, 0xac, 0x14, 0xfe, 0x0f, }, (0 << 4) | 0, 10, Cards3, 1, Monsters3},
	
{ { 0x20, 0x3a, 0x04, 0xa5, 0xd5, 0x01, 0xf2, 0x3e, 0x20, 0x5e, 0x90, 0x3a, 0x8b, 0xa2, 0x69, 0x00, 0xfe, 0x0f, }, (0 << 4) | 0, 4, Cards4, 4, Monsters4},
	
{ { 0x02, 0xb6, 0x06, 0xaa, 0x9b, 0xe4, 0xda, 0x44, 0xe8, 0xac, 0x04, 0x62, 0x39, 0x2c, 0x1a, 0x10, 0xff, 0x0f, }, (0 << 4) | 0, 10, Cards5, 1, Monsters5},
	
{ { 0x00, 0xbb, 0x02, 0x27, 0x46, 0x83, 0x22, 0x45, 0x35, 0x45, 0x21, 0xb2, 0x16, 0xa3, 0x93, 0x80, 0xfe, 0x0f, }, (0 << 4) | 0, 12, Cards6, 1, Monsters6},
	
{ { 0xcc, 0x8a, 0x58, 0x20, 0x7a, 0x13, 0x62, 0x07, 0x62, 0xeb, 0x00, 0xb2, 0x1d, 0xa1, 0x66, 0x20, 0xfe, 0x0f, }, (0 << 4) | 0, 14, Cards7, 2, Monsters7},
	
{ { 0x40, 0xb3, 0x10, 0xa8, 0x31, 0x98, 0x17, 0x40, 0xe6, 0x64, 0x26, 0x42, 0x56, 0xa0, 0x6e, 0x00, 0xfe, 0x0f, }, (0 << 4) | 0, 16, Cards8, 2, Monsters8},
	
{ { 0x0a, 0x82, 0x71, 0x39, 0x14, 0xa8, 0x36, 0x8a, 0xaf, 0x41, 0x42, 0xa2, 0x3d, 0x20, 0x72, 0x10, 0xfe, 0x0f, }, (0 << 4) | 0, 24, Cards9, 2, Monsters9},
};
