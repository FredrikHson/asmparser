%{
#include <stdio.h>
#include <string.h>
#include "asm.tab.h"
void showError();
%}

%option yylineno

numbers     ([0-9])+
float       ([0-9]+\.[0-9]*)[fd]?
alpha       ([a-zA-Z])+
comment     (;.*)
jumploc     ^([a-zA-Z])+

%%

{comment}      { printf("%s\n" ,yytext);}
"ADC"          { printf("ADC - add with carry\n");}
"AND"          { printf("AND - and (with accumulator)\n");}
"ASL"          { printf("ASL - arithmetic shift left\n");}
"BCC"          { printf("BCC - branch on carry clear\n");}
"BCS"          { printf("BCS - branch on carry set\n");}
"BEQ"          { printf("BEQ - branch on equal (zero set)\n");}
"BIT"          { printf("BIT - bit test\n");}
"BMI"          { printf("BMI - branch on minus (negative set)\n");}
"BNE"          { printf("BNE - branch on not equal (zero clear)\n");}
"BPL"          { printf("BPL - branch on plus (negative clear)\n");}
"BRK"          { printf("BRK - break / interrupt\n");}
"BVC"          { printf("BVC - branch on overflow clear\n");}
"BVS"          { printf("BVS - branch on overflow set\n");}
"CLC"          { printf("CLC - clear carry\n");}
"CLD"          { printf("CLD - clear decimal\n");}
"CLI"          { printf("CLI - clear interrupt disable\n");}
"CLV"          { printf("CLV - clear overflow\n");}
"CMP"          { printf("CMP - compare (with accumulator)\n");}
"CPX"          { printf("CPX - compare with X\n");}
"CPY"          { printf("CPY - compare with Y\n");}
"DEC"          { printf("DEC - decrement\n");}
"DEX"          { printf("DEX - decrement X\n");}
"DEY"          { printf("DEY - decrement Y\n");}
"EOR"          { printf("EOR - exclusive or (with accumulator)\n");}
"INC"          { printf("INC - increment\n");}
"INX"          { printf("INX - increment X\n");}
"INY"          { printf("INY - increment Y\n");}
"JMP"          { printf("JMP - jump\n");}
"JSR"          { printf("JSR - jump subroutine\n");}
"LDA"          { printf("LDA - load accumulator\n");}
"LDX"          { printf("LDX - load X\n");}
"LDY"          { printf("LDY - load Y\n");}
"LSR"          { printf("LSR - logical shift right\n");}
"NOP"          { printf("NOP - no operation\n");}
"ORA"          { printf("ORA - or with accumulator\n");}
"PHA"          { printf("PHA - push accumulator\n");}
"PHP"          { printf("PHP - push processor status (SR)\n");}
"PLA"          { printf("PLA - pull accumulator\n");}
"PLP"          { printf("PLP - pull processor status (SR)\n");}
"ROL"          { printf("ROL - rotate left\n");}
"ROR"          { printf("ROR - rotate right\n");}
"RTI"          { printf("RTI - return from interrupt\n");}
"RTS"          { printf("RTS - return from subroutine\n");}
"SBC"          { printf("SBC - subtract with carry\n");}
"SEC"          { printf("SEC - set carry\n");}
"SED"          { printf("SED - set decimal\n");}
"SEI"          { printf("SEI - set interrupt disable\n");}
"STA"          { printf("STA - store accumulator\n");}
"STX"          { printf("STX - store X\n");}
"STY"          { printf("STY - store Y\n");}
"TAX"          { printf("TAX - transfer accumulator to X\n");}
"TAY"          { printf("TAY - transfer accumulator to Y\n");}
"TSX"          { printf("TSX - transfer stack pointer to X\n");}
"TXA"          { printf("TXA - transfer X to accumulator\n");}
"TXS"          { printf("TXS - transfer X to stack pointer\n");}
"TYA"          { printf("TYA - transfer Y to accumulator\n");}
{jumploc}      { printf("jump location %s\n",yytext);}

\n             { yylineno++;}
.              { /* unparsed */ }

%%


void showError(){
    printf("%s",yytext);
}
