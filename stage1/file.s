	.file	"file.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"Error opening the file: %s\n"
	.text
	.align	1
	.globl	read_whole_file
	.type	read_whole_file, @function
read_whole_file:
	addi	sp,sp,-224
	sd	ra,216(sp)
	sd	s0,208(sp)
	addi	s0,sp,224
	sd	a0,-216(s0)
	sd	a1,-224(s0)
	li	a1,0
	ld	a0,-224(s0)
	call	open_file
	mv	a5,a0
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sext.w	a5,a5
	bge	a5,zero,.L2
	ld	a1,-224(s0)
	lui	a5,%hi(.LC0)
	addi	a0,a5,%lo(.LC0)
	call	my_printf
	li	a5,0
	j	.L7
.L2:
	addi	a4,s0,-160
	lw	a5,-24(s0)
	li	a2,128
	mv	a1,a4
	mv	a0,a5
	call	read_file
	mv	a5,a0
	sw	a5,-20(s0)
	addi	a5,s0,-160
	sd	a5,-176(s0)
	lw	a5,-20(s0)
	sd	a5,-168(s0)
	ld	a1,-176(s0)
	ld	a2,-168(s0)
	ld	a0,-216(s0)
	call	from_string_view
	sd	a0,-32(s0)
	j	.L4
.L5:
	addi	a5,s0,-160
	sd	a5,-208(s0)
	lw	a5,-20(s0)
	sd	a5,-200(s0)
	ld	a1,-208(s0)
	ld	a2,-200(s0)
	ld	a0,-32(s0)
	call	append_string_view
	addi	a4,s0,-160
	lw	a5,-24(s0)
	li	a2,128
	mv	a1,a4
	mv	a0,a5
	call	read_file
	mv	a5,a0
	sw	a5,-20(s0)
.L4:
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,128
	beq	a4,a5,.L5
	lw	a5,-20(s0)
	sext.w	a4,a5
	li	a5,-1
	bne	a4,a5,.L6
	ld	a0,-32(s0)
	call	string_destroy
	ld	a1,-32(s0)
	ld	a0,-216(s0)
	call	my_free
	li	a5,0
	j	.L7
.L6:
	addi	a5,s0,-160
	sd	a5,-192(s0)
	lw	a5,-20(s0)
	sd	a5,-184(s0)
	ld	a1,-192(s0)
	ld	a2,-184(s0)
	ld	a0,-32(s0)
	call	append_string_view
	lw	a5,-24(s0)
	mv	a0,a5
	call	close
	ld	a5,-32(s0)
.L7:
	mv	a0,a5
	ld	ra,216(sp)
	ld	s0,208(sp)
	addi	sp,sp,224
	jr	ra
	.size	read_whole_file, .-read_whole_file
	.ident	"GCC: () 13.2.0"
