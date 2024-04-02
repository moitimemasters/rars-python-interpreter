	.text
.align 2
	.globl	print_string
print_string:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
 #APP
# 23 "syscall.c" 1
	mv a0, a5
	li a7, 4
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	print_char
print_char:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sb	a5,-17(s0)
	lbu	a5,-17(s0)
 #APP
# 33 "syscall.c" 1
	mv a0, a5
	li a7, 11
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	print_int
print_int:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
 #APP
# 43 "syscall.c" 1
	mv a0, a5
	li a7, 1
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	read_int
read_int:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
 #APP
# 54 "syscall.c" 1
	li a7, 5
	ecall
	mv a5, a0
	
# 0 "" 2
 #NO_APP
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	sbrk
sbrk:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	a5,a0
	sw	a5,-36(s0)
	lw	a5,-36(s0)
 #APP
# 66 "syscall.c" 1
	mv a0, a5
	li a7, 9
	ecall
	mv a5, a0
	
# 0 "" 2
 #NO_APP
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.globl	read_float
read_float:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
 #APP
# 79 "syscall.c" 1
	li a7, 6
	ecall
	fmv.s fa5, fa0
	
# 0 "" 2
 #NO_APP
	fsw	fa5,-20(s0)
	flw	fa5,-20(s0)
	fmv.s	fa0,fa5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	read_double
read_double:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
 #APP
# 91 "syscall.c" 1
	li a7, 7
	ecall
	fmv.d fa5, fa0
	
# 0 "" 2
 #NO_APP
	fsd	fa5,-24(s0)
	fld	fa5,-24(s0)
	fmv.d	fa0,fa5
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	print_float
print_float:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	fsw	fa0,-20(s0)
	flw	fa5,-20(s0)
 #APP
# 102 "syscall.c" 1
	fmv.s fa0, fa5
	li a7, 2
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	print_double
print_double:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	fsd	fa0,-24(s0)
	fld	fa5,-24(s0)
 #APP
# 112 "syscall.c" 1
	fmv.d fa0, fa5
	li a7, 3
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	read_string
read_string:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	mv	a5,a1
	sw	a5,-28(s0)
	ld	a5,-24(s0)
	lw	a4,-28(s0)
 #APP
# 122 "syscall.c" 1
	mv a0, a5
	mv a1, a4
	li a7, 8
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	open_file
open_file:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	ld	a5,-40(s0)
	lw	a4,-44(s0)
 #APP
# 134 "syscall.c" 1
	mv a0, a5
	mv a1, a4
	li a7, 1024
	ecall
	mv a5, a0
	
# 0 "" 2
 #NO_APP
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.globl	read_file
read_file:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	mv	a5,a0
	sd	a1,-48(s0)
	mv	a4,a2
	sw	a5,-36(s0)
	mv	a5,a4
	sw	a5,-40(s0)
	lw	a5,-36(s0)
	mv	a4,a5
	ld	a5,-48(s0)
	lw	a3,-40(s0)
 #APP
# 148 "syscall.c" 1
	mv a0, a4
	mv a1, a5
	mv a2, a3
	li a7, 63
	ecall
	mv a5, a0
	
# 0 "" 2
 #NO_APP
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.globl	close
close:
	addi	sp,sp,-32
	sd	s0,24(sp)
	addi	s0,sp,32
	mv	a5,a0
	sw	a5,-20(s0)
	lw	a5,-20(s0)
 #APP
# 162 "syscall.c" 1
	mv a0, a5
	li a7, 57
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,24(sp)
	addi	sp,sp,32
	jr	ra
	.globl	Exit
Exit:
	addi	sp,sp,-16
	sd	s0,8(sp)
	addi	s0,sp,16
 #APP
# 172 "syscall.c" 1
	li a7, 10
	ecall
	
# 0 "" 2
 #NO_APP
	nop
	ld	s0,8(sp)
	addi	sp,sp,16
	jr	ra
