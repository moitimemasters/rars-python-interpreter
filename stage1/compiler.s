	.file	"compiler.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	compile_node
	.type	compile_node, @function
compile_node:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	sd	a2,-40(s0)
	nop
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	compile_node, .-compile_node
	.align	1
	.globl	create_instruction
	.type	create_instruction, @function
create_instruction:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	li	a1,24
	ld	a0,-40(s0)
	call	my_alloc
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lw	a4,-44(s0)
	sw	a4,0(a5)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	create_instruction, .-create_instruction
	.align	1
	.globl	compile_ident
	.type	compile_ident, @function
compile_ident:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	li	a1,1
	ld	a0,-40(s0)
	call	create_instruction
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	ld	a4,-48(s0)
	ld	a3,8(a4)
	sd	a3,8(a5)
	ld	a4,16(a4)
	sd	a4,16(a5)
	ld	a1,-24(s0)
	ld	a0,-56(s0)
	call	linked_list_push
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	compile_ident, .-compile_ident
	.align	1
	.globl	compile_number
	.type	compile_number, @function
compile_number:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,-56(s0)
	li	a1,5
	ld	a0,-40(s0)
	call	create_instruction
	sd	a0,-24(s0)
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	compile_number, .-compile_number
	.ident	"GCC: () 13.2.0"
