	.file	"lib.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	linked_list_create
	.type	linked_list_create, @function
linked_list_create:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	li	a1,16
	ld	a0,-40(s0)
	call	my_alloc
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	sd	zero,0(a5)
	ld	a5,-24(s0)
	ld	a4,-40(s0)
	sd	a4,8(a5)
	nop
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	linked_list_create, .-linked_list_create
	.align	1
	.globl	linked_list_push
	.type	linked_list_push, @function
linked_list_push:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	bne	a5,zero,.L3
	ld	a5,-40(s0)
	ld	a5,8(a5)
	li	a1,16
	mv	a0,a5
	call	my_alloc
	mv	a4,a0
	ld	a5,-40(s0)
	sd	a4,0(a5)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	ld	a4,-48(s0)
	sd	a4,0(a5)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	sd	zero,8(a5)
	j	.L7
.L3:
	ld	a5,-40(s0)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	j	.L5
.L6:
	ld	a5,-24(s0)
	ld	a5,8(a5)
	sd	a5,-24(s0)
.L5:
	ld	a5,-24(s0)
	ld	a5,8(a5)
	bne	a5,zero,.L6
	ld	a5,-40(s0)
	ld	a5,8(a5)
	li	a1,16
	mv	a0,a5
	call	my_alloc
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	ld	a4,-48(s0)
	sd	a4,0(a5)
	ld	a5,-32(s0)
	sd	zero,8(a5)
	ld	a5,-24(s0)
	ld	a4,-32(s0)
	sd	a4,8(a5)
.L7:
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	linked_list_push, .-linked_list_push
	.align	1
	.globl	free_list_node
	.type	free_list_node, @function
free_list_node:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	sd	a1,-32(s0)
	ld	a5,-32(s0)
	beq	a5,zero,.L11
	ld	a5,-32(s0)
	ld	a5,8(a5)
	mv	a1,a5
	ld	a0,-24(s0)
	call	free_list_node
	ld	a1,-32(s0)
	ld	a0,-24(s0)
	call	my_free
	ld	a5,-32(s0)
	sd	zero,8(a5)
	ld	a5,-32(s0)
	sd	zero,0(a5)
	j	.L8
.L11:
	nop
.L8:
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	free_list_node, .-free_list_node
	.align	1
	.globl	linked_list_free
	.type	linked_list_free, @function
linked_list_free:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	ld	a4,8(a5)
	ld	a5,-24(s0)
	ld	a5,0(a5)
	mv	a1,a5
	mv	a0,a4
	call	free_list_node
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	linked_list_free, .-linked_list_free
	.align	1
	.globl	linked_list_at
	.type	linked_list_at, @function
linked_list_at:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	bne	a5,zero,.L16
	li	a5,0
	j	.L15
.L18:
	ld	a5,-24(s0)
	ld	a5,8(a5)
	beq	a5,zero,.L17
	ld	a5,-24(s0)
	ld	a5,8(a5)
	sd	a5,-24(s0)
	j	.L16
.L17:
	li	a5,0
	j	.L15
.L16:
	ld	a5,-48(s0)
	addi	a4,a5,-1
	sd	a4,-48(s0)
	bne	a5,zero,.L18
	ld	a5,-24(s0)
.L15:
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	linked_list_at, .-linked_list_at
	.align	1
	.globl	string_view
	.type	string_view, @function
string_view:
	addi	sp,sp,-64
	sd	s0,56(sp)
	addi	s0,sp,64
	sd	a0,-56(s0)
	sd	a1,-64(s0)
	ld	a5,-56(s0)
	sd	a5,-32(s0)
	ld	a5,-64(s0)
	sd	a5,-24(s0)
	ld	a4,-32(s0)
	ld	a5,-24(s0)
	mv	a2,a4
	mv	a3,a5
	mv	a4,a2
	mv	a5,a3
	mv	a0,a4
	mv	a1,a5
	ld	s0,56(sp)
	addi	sp,sp,64
	jr	ra
	.size	string_view, .-string_view
	.align	1
	.globl	c_string_view
	.type	c_string_view, @function
c_string_view:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	sd	s2,56(sp)
	sd	s3,48(sp)
	addi	s0,sp,80
	sd	a0,-72(s0)
	ld	a0,-72(s0)
	call	my_strlen
	mv	a5,a0
	mv	a4,a5
	ld	a5,-72(s0)
	sd	a5,-48(s0)
	sd	a4,-40(s0)
	ld	a4,-48(s0)
	ld	a5,-40(s0)
	mv	s2,a4
	mv	s3,a5
	mv	a4,s2
	mv	a5,s3
	mv	a0,a4
	mv	a1,a5
	ld	ra,72(sp)
	ld	s0,64(sp)
	ld	s2,56(sp)
	ld	s3,48(sp)
	addi	sp,sp,80
	jr	ra
	.size	c_string_view, .-c_string_view
	.align	1
	.globl	const_string_view
	.type	const_string_view, @function
const_string_view:
	addi	sp,sp,-80
	sd	ra,72(sp)
	sd	s0,64(sp)
	sd	s2,56(sp)
	sd	s3,48(sp)
	addi	s0,sp,80
	sd	a0,-72(s0)
	ld	a0,-72(s0)
	call	my_strlen
	mv	a5,a0
	mv	a4,a5
	ld	a5,-72(s0)
	sd	a5,-48(s0)
	sd	a4,-40(s0)
	ld	a4,-48(s0)
	ld	a5,-40(s0)
	mv	s2,a4
	mv	s3,a5
	mv	a4,s2
	mv	a5,s3
	mv	a0,a4
	mv	a1,a5
	ld	ra,72(sp)
	ld	s0,64(sp)
	ld	s2,56(sp)
	ld	s3,48(sp)
	addi	sp,sp,80
	jr	ra
	.size	const_string_view, .-const_string_view
	.align	1
	.globl	reverse
	.type	reverse, @function
reverse:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sw	zero,-20(s0)
	ld	a0,-40(s0)
	call	my_strlen
	mv	a5,a0
	addiw	a5,a5,-1
	sw	a5,-24(s0)
	j	.L26
.L27:
	lw	a5,-20(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	sb	a5,-25(s0)
	lw	a5,-24(s0)
	ld	a4,-40(s0)
	add	a4,a4,a5
	lw	a5,-20(s0)
	ld	a3,-40(s0)
	add	a5,a3,a5
	lbu	a4,0(a4)
	sb	a4,0(a5)
	lw	a5,-24(s0)
	ld	a4,-40(s0)
	add	a5,a4,a5
	lbu	a4,-25(s0)
	sb	a4,0(a5)
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addiw	a5,a5,-1
	sw	a5,-24(s0)
.L26:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L27
	nop
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	reverse, .-reverse
	.align	1
	.globl	my_itoa
	.type	my_itoa, @function
my_itoa:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	mv	a5,a0
	sd	a1,-48(s0)
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	sw	a5,-24(s0)
	lw	a5,-24(s0)
	sext.w	a5,a5
	bge	a5,zero,.L29
	lw	a5,-36(s0)
	negw	a5,a5
	sw	a5,-36(s0)
.L29:
	sw	zero,-20(s0)
.L30:
	lw	a5,-36(s0)
	mv	a4,a5
	li	a5,10
	remw	a5,a4,a5
	sext.w	a5,a5
	andi	a4,a5,0xff
	lw	a5,-20(s0)
	addiw	a3,a5,1
	sw	a3,-20(s0)
	mv	a3,a5
	ld	a5,-48(s0)
	add	a5,a5,a3
	addiw	a4,a4,48
	andi	a4,a4,0xff
	sb	a4,0(a5)
	lw	a5,-36(s0)
	mv	a4,a5
	li	a5,10
	divw	a5,a4,a5
	sw	a5,-36(s0)
	lw	a5,-36(s0)
	sext.w	a5,a5
	bgt	a5,zero,.L30
	lw	a5,-24(s0)
	sext.w	a5,a5
	bge	a5,zero,.L31
	lw	a5,-20(s0)
	addiw	a4,a5,1
	sw	a4,-20(s0)
	mv	a4,a5
	ld	a5,-48(s0)
	add	a5,a5,a4
	li	a4,45
	sb	a4,0(a5)
.L31:
	lw	a5,-20(s0)
	ld	a4,-48(s0)
	add	a5,a4,a5
	sb	zero,0(a5)
	ld	a0,-48(s0)
	call	reverse
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	my_itoa, .-my_itoa
	.align	1
	.globl	my_vsprintf
	.type	my_vsprintf, @function
my_vsprintf:
	addi	sp,sp,-96
	sd	ra,88(sp)
	sd	s0,80(sp)
	addi	s0,sp,96
	sd	a0,-72(s0)
	sd	a1,-80(s0)
	sd	a2,-88(s0)
	sw	zero,-20(s0)
	j	.L33
.L38:
	lw	a5,-20(s0)
	ld	a4,-80(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,37
	beq	a4,a5,.L34
	lw	a5,-20(s0)
	ld	a4,-80(s0)
	add	a4,a4,a5
	ld	a5,-72(s0)
	addi	a3,a5,1
	sd	a3,-72(s0)
	lbu	a4,0(a4)
	sb	a4,0(a5)
	j	.L35
.L34:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	ld	a4,-80(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	sext.w	a4,a5
	mv	a3,a4
	li	a5,100
	beq	a3,a5,.L36
	li	a5,115
	beq	a4,a5,.L37
	j	.L35
.L36:
	ld	a5,-88(s0)
	addi	a4,a5,8
	sd	a4,-88(s0)
	lw	a5,0(a5)
	sw	a5,-36(s0)
	addi	a4,s0,-56
	lw	a5,-36(s0)
	mv	a1,a4
	mv	a0,a5
	call	my_itoa
	addi	a5,s0,-56
	mv	a1,a5
	ld	a0,-72(s0)
	call	my_strcpy
	addi	a5,s0,-56
	mv	a0,a5
	call	my_strlen
	mv	a5,a0
	mv	a4,a5
	ld	a5,-72(s0)
	add	a5,a5,a4
	sd	a5,-72(s0)
	j	.L35
.L37:
	ld	a5,-88(s0)
	addi	a4,a5,8
	sd	a4,-88(s0)
	ld	a5,0(a5)
	sd	a5,-32(s0)
	ld	a1,-32(s0)
	ld	a0,-72(s0)
	call	my_strcpy
	ld	a0,-32(s0)
	call	my_strlen
	mv	a5,a0
	mv	a4,a5
	ld	a5,-72(s0)
	add	a5,a5,a4
	sd	a5,-72(s0)
	nop
.L35:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L33:
	lw	a5,-20(s0)
	ld	a4,-80(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L38
	ld	a5,-72(s0)
	sb	zero,0(a5)
	nop
	ld	ra,88(sp)
	ld	s0,80(sp)
	addi	sp,sp,96
	jr	ra
	.size	my_vsprintf, .-my_vsprintf
	.align	1
	.globl	my_sprintf
	.type	my_sprintf, @function
my_sprintf:
	addi	sp,sp,-112
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	sd	a2,0(s0)
	sd	a3,8(s0)
	sd	a4,16(s0)
	sd	a5,24(s0)
	sd	a6,32(s0)
	sd	a7,40(s0)
	addi	a5,s0,48
	sd	a5,-56(s0)
	ld	a5,-56(s0)
	addi	a5,a5,-48
	sd	a5,-24(s0)
	ld	a5,-24(s0)
	mv	a2,a5
	ld	a1,-48(s0)
	ld	a0,-40(s0)
	call	my_vsprintf
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,112
	jr	ra
	.size	my_sprintf, .-my_sprintf
	.align	1
	.globl	my_printf
	.type	my_printf, @function
my_printf:
	addi	sp,sp,-368
	sd	ra,296(sp)
	sd	s0,288(sp)
	addi	s0,sp,304
	sd	a0,-296(s0)
	sd	a1,8(s0)
	sd	a2,16(s0)
	sd	a3,24(s0)
	sd	a4,32(s0)
	sd	a5,40(s0)
	sd	a6,48(s0)
	sd	a7,56(s0)
	addi	a5,s0,64
	sd	a5,-304(s0)
	ld	a5,-304(s0)
	addi	a5,a5,-56
	sd	a5,-280(s0)
	ld	a4,-280(s0)
	addi	a5,s0,-272
	mv	a2,a4
	ld	a1,-296(s0)
	mv	a0,a5
	call	my_vsprintf
	addi	a5,s0,-272
	mv	a0,a5
	call	printstr
	nop
	ld	ra,296(sp)
	ld	s0,288(sp)
	addi	sp,sp,368
	jr	ra
	.size	my_printf, .-my_printf
	.ident	"GCC: () 13.2.0"
