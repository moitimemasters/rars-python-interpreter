	.file	"lib.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.align	1
	.globl	stack_pop
	.type	stack_pop, @function
stack_pop:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	beq	a5,zero,.L4
	ld	a5,-40(s0)
	ld	a5,16(a5)
	addi	a4,a5,-1
	ld	a5,-40(s0)
	sd	a4,16(a5)
	ld	a5,-24(s0)
	ld	a4,8(a5)
	ld	a5,-40(s0)
	sd	a4,0(a5)
	j	.L1
.L4:
	nop
.L1:
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	stack_pop, .-stack_pop
	.align	1
	.globl	stack_push
	.type	stack_push, @function
stack_push:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	sd	a1,-48(s0)
	ld	a5,-40(s0)
	ld	a5,16(a5)
	addi	a4,a5,1
	ld	a5,-40(s0)
	sd	a4,16(a5)
	ld	a5,-40(s0)
	ld	a5,8(a5)
	li	a1,16
	mv	a0,a5
	call	my_alloc
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	ld	a4,-48(s0)
	sd	a4,0(a5)
	ld	a5,-40(s0)
	ld	a4,0(a5)
	ld	a5,-24(s0)
	sd	a4,8(a5)
	ld	a5,-40(s0)
	ld	a4,-24(s0)
	sd	a4,0(a5)
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	stack_push, .-stack_push
	.align	1
	.globl	stack_free
	.type	stack_free, @function
stack_free:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	j	.L7
.L8:
	ld	a0,-24(s0)
	call	stack_pop
.L7:
	ld	a5,-24(s0)
	ld	a5,0(a5)
	bne	a5,zero,.L8
	nop
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	stack_free, .-stack_free
	.align	1
	.globl	stack_create
	.type	stack_create, @function
stack_create:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	li	a1,24
	ld	a0,-40(s0)
	call	my_alloc
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	sd	zero,0(a5)
	ld	a5,-24(s0)
	ld	a4,-40(s0)
	sd	a4,8(a5)
	ld	a5,-24(s0)
	sd	zero,16(a5)
	ld	a5,-24(s0)
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	stack_create, .-stack_create
	.align	1
	.globl	linked_list_create
	.type	linked_list_create, @function
linked_list_create:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	li	a1,24
	ld	a0,-40(s0)
	call	my_alloc
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	sd	zero,0(a5)
	ld	a5,-24(s0)
	ld	a4,-40(s0)
	sd	a4,8(a5)
	ld	a5,-24(s0)
	sd	zero,16(a5)
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
	ld	a5,16(a5)
	addi	a4,a5,1
	ld	a5,-40(s0)
	sd	a4,16(a5)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	bne	a5,zero,.L13
	ld	a5,-40(s0)
	ld	a5,8(a5)
	li	a1,24
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
	ld	a5,-40(s0)
	ld	a5,0(a5)
	sd	zero,16(a5)
	j	.L17
.L13:
	ld	a5,-40(s0)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	j	.L15
.L16:
	ld	a5,-24(s0)
	ld	a5,8(a5)
	sd	a5,-24(s0)
.L15:
	ld	a5,-24(s0)
	ld	a5,8(a5)
	bne	a5,zero,.L16
	ld	a5,-40(s0)
	ld	a5,8(a5)
	li	a1,24
	mv	a0,a5
	call	my_alloc
	sd	a0,-32(s0)
	ld	a5,-32(s0)
	ld	a4,-48(s0)
	sd	a4,0(a5)
	ld	a5,-32(s0)
	sd	zero,8(a5)
	ld	a5,-32(s0)
	ld	a4,-24(s0)
	sd	a4,16(a5)
	ld	a5,-24(s0)
	ld	a4,-32(s0)
	sd	a4,8(a5)
.L17:
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
	beq	a5,zero,.L21
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
	j	.L18
.L21:
	nop
.L18:
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
	j	.L30
.L31:
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
.L30:
	lw	a5,-20(s0)
	mv	a4,a5
	lw	a5,-24(s0)
	sext.w	a4,a4
	sext.w	a5,a5
	blt	a4,a5,.L31
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
	bge	a5,zero,.L33
	lw	a5,-36(s0)
	negw	a5,a5
	sw	a5,-36(s0)
.L33:
	sw	zero,-20(s0)
.L34:
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
	bgt	a5,zero,.L34
	lw	a5,-24(s0)
	sext.w	a5,a5
	bge	a5,zero,.L35
	lw	a5,-20(s0)
	addiw	a4,a5,1
	sw	a4,-20(s0)
	mv	a4,a5
	ld	a5,-48(s0)
	add	a5,a5,a4
	li	a4,45
	sb	a4,0(a5)
.L35:
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
	addi	sp,sp,-112
	sd	ra,104(sp)
	sd	s0,96(sp)
	addi	s0,sp,112
	sd	a0,-88(s0)
	sd	a1,-96(s0)
	sd	a2,-104(s0)
	sw	zero,-20(s0)
	j	.L37
.L43:
	lw	a5,-20(s0)
	ld	a4,-96(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	mv	a4,a5
	li	a5,37
	beq	a4,a5,.L38
	lw	a5,-20(s0)
	ld	a4,-96(s0)
	add	a4,a4,a5
	ld	a5,-88(s0)
	addi	a3,a5,1
	sd	a3,-88(s0)
	lbu	a4,0(a4)
	sb	a4,0(a5)
	j	.L39
.L38:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
	lw	a5,-20(s0)
	ld	a4,-96(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	sext.w	a5,a5
	mv	a3,a5
	li	a4,115
	beq	a3,a4,.L40
	mv	a3,a5
	li	a4,115
	bgt	a3,a4,.L39
	mv	a3,a5
	li	a4,100
	beq	a3,a4,.L41
	mv	a4,a5
	li	a5,102
	beq	a4,a5,.L42
	j	.L39
.L41:
	ld	a5,-104(s0)
	addi	a4,a5,8
	sd	a4,-104(s0)
	lw	a5,0(a5)
	sw	a5,-60(s0)
	addi	a4,s0,-80
	lw	a5,-60(s0)
	mv	a1,a4
	mv	a0,a5
	call	my_itoa
	addi	a5,s0,-80
	mv	a1,a5
	ld	a0,-88(s0)
	call	my_strcpy
	addi	a5,s0,-80
	mv	a0,a5
	call	my_strlen
	mv	a5,a0
	mv	a4,a5
	ld	a5,-88(s0)
	add	a5,a5,a4
	sd	a5,-88(s0)
	j	.L39
.L40:
	ld	a5,-104(s0)
	addi	a4,a5,8
	sd	a4,-104(s0)
	ld	a5,0(a5)
	sd	a5,-32(s0)
	ld	a1,-32(s0)
	ld	a0,-88(s0)
	call	my_strcpy
	ld	a0,-32(s0)
	call	my_strlen
	mv	a5,a0
	mv	a4,a5
	ld	a5,-88(s0)
	add	a5,a5,a4
	sd	a5,-88(s0)
	j	.L39
.L42:
	ld	a5,-104(s0)
	addi	a4,a5,8
	sd	a4,-104(s0)
	fld	fa5,0(a5)
	fsd	fa5,-40(s0)
	fld	fa5,-40(s0)
	fcvt.w.d a5,fa5,rtz
	sw	a5,-44(s0)
	lw	a5,-44(s0)
	fcvt.d.w	fa5,a5
	fld	fa4,-40(s0)
	fsub.d	fa5,fa4,fa5
	fsd	fa5,-56(s0)
	lw	a5,-44(s0)
	ld	a1,-88(s0)
	mv	a0,a5
	call	my_itoa
	ld	a0,-88(s0)
	call	my_strlen
	mv	a5,a0
	mv	a4,a5
	ld	a5,-88(s0)
	add	a5,a5,a4
	sd	a5,-88(s0)
	ld	a5,-88(s0)
	addi	a4,a5,1
	sd	a4,-88(s0)
	li	a4,46
	sb	a4,0(a5)
	fld	fa4,-56(s0)
	lui	a5,%hi(.LC0)
	fld	fa5,%lo(.LC0)(a5)
	fmul.d	fa5,fa4,fa5
	fcvt.w.d a5,fa5,rtz
	sext.w	a5,a5
	ld	a1,-88(s0)
	mv	a0,a5
	call	my_itoa
	ld	a0,-88(s0)
	call	my_strlen
	mv	a5,a0
	mv	a4,a5
	ld	a5,-88(s0)
	add	a5,a5,a4
	sd	a5,-88(s0)
	nop
.L39:
	lw	a5,-20(s0)
	addiw	a5,a5,1
	sw	a5,-20(s0)
.L37:
	lw	a5,-20(s0)
	ld	a4,-96(s0)
	add	a5,a4,a5
	lbu	a5,0(a5)
	bne	a5,zero,.L43
	ld	a5,-88(s0)
	sb	zero,0(a5)
	nop
	ld	ra,104(sp)
	ld	s0,96(sp)
	addi	sp,sp,112
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
	.align	1
	.globl	strhash
	.type	strhash, @function
strhash:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-48(s0)
	sd	a1,-40(s0)
	sw	zero,-20(s0)
	sw	zero,-24(s0)
	j	.L47
.L48:
	lw	a5,-20(s0)
	mv	a4,a5
	mv	a5,a4
	slliw	a5,a5,5
	subw	a5,a5,a4
	sext.w	a4,a5
	ld	a3,-48(s0)
	lw	a5,-24(s0)
	add	a5,a3,a5
	lbu	a5,0(a5)
	sext.w	a5,a5
	addw	a5,a4,a5
	sw	a5,-20(s0)
	lw	a5,-24(s0)
	addiw	a5,a5,1
	sw	a5,-24(s0)
.L47:
	lw	a4,-24(s0)
	ld	a5,-40(s0)
	bltu	a4,a5,.L48
	lw	a5,-20(s0)
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	strhash, .-strhash
	.align	1
	.globl	hash_table_create
	.type	hash_table_create, @function
hash_table_create:
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
	ld	a4,-40(s0)
	sd	a4,0(a5)
	ld	a0,-40(s0)
	call	linked_list_create
	mv	a4,a0
	ld	a5,-24(s0)
	sd	a4,8(a5)
	nop
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	hash_table_create, .-hash_table_create
	.align	1
	.globl	hash_table_free
	.type	hash_table_free, @function
hash_table_free:
	addi	sp,sp,-32
	sd	ra,24(sp)
	sd	s0,16(sp)
	addi	s0,sp,32
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	ld	a5,8(a5)
	mv	a0,a5
	call	linked_list_free
	nop
	ld	ra,24(sp)
	ld	s0,16(sp)
	addi	sp,sp,32
	jr	ra
	.size	hash_table_free, .-hash_table_free
	.align	1
	.globl	hash_table_insert
	.type	hash_table_insert, @function
hash_table_insert:
	addi	sp,sp,-64
	sd	ra,56(sp)
	sd	s0,48(sp)
	addi	s0,sp,64
	sd	a0,-40(s0)
	mv	a5,a1
	sd	a2,-56(s0)
	sw	a5,-44(s0)
	ld	a5,-40(s0)
	ld	a5,0(a5)
	li	a1,16
	mv	a0,a5
	call	my_alloc
	sd	a0,-24(s0)
	ld	a5,-24(s0)
	lw	a4,-44(s0)
	sw	a4,0(a5)
	ld	a5,-24(s0)
	ld	a4,-56(s0)
	sd	a4,8(a5)
	ld	a5,-40(s0)
	ld	a5,8(a5)
	ld	a1,-24(s0)
	mv	a0,a5
	call	linked_list_push
	nop
	ld	ra,56(sp)
	ld	s0,48(sp)
	addi	sp,sp,64
	jr	ra
	.size	hash_table_insert, .-hash_table_insert
	.align	1
	.globl	hash_table_insert_string
	.type	hash_table_insert_string, @function
hash_table_insert_string:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-24(s0)
	sd	a1,-40(s0)
	sd	a2,-32(s0)
	sd	a3,-48(s0)
	ld	a0,-40(s0)
	ld	a1,-32(s0)
	call	strhash
	mv	a5,a0
	ld	a2,-48(s0)
	mv	a1,a5
	ld	a0,-24(s0)
	call	hash_table_insert
	nop
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	hash_table_insert_string, .-hash_table_insert_string
	.align	1
	.globl	hash_table_get
	.type	hash_table_get, @function
hash_table_get:
	addi	sp,sp,-48
	sd	s0,40(sp)
	addi	s0,sp,48
	sd	a0,-40(s0)
	mv	a5,a1
	sw	a5,-44(s0)
	ld	a5,-40(s0)
	ld	a5,8(a5)
	ld	a5,0(a5)
	sd	a5,-24(s0)
	j	.L56
.L59:
	ld	a5,-24(s0)
	ld	a5,0(a5)
	sd	a5,-32(s0)
	ld	a5,-32(s0)
	lw	a4,0(a5)
	lw	a5,-44(s0)
	sext.w	a5,a5
	bne	a5,a4,.L57
	ld	a5,-32(s0)
	ld	a5,8(a5)
	j	.L58
.L57:
	ld	a5,-24(s0)
	ld	a5,8(a5)
	sd	a5,-24(s0)
.L56:
	ld	a5,-24(s0)
	bne	a5,zero,.L59
	li	a5,0
.L58:
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	hash_table_get, .-hash_table_get
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
	sd	zero,-32(s0)
	j	.L61
.L64:
	ld	a5,-24(s0)
	bne	a5,zero,.L62
	li	a5,0
	j	.L63
.L62:
	ld	a5,-24(s0)
	ld	a5,8(a5)
	sd	a5,-24(s0)
	ld	a5,-32(s0)
	addi	a5,a5,1
	sd	a5,-32(s0)
.L61:
	ld	a4,-32(s0)
	ld	a5,-48(s0)
	bltu	a4,a5,.L64
	ld	a5,-24(s0)
	bne	a5,zero,.L65
	li	a5,0
	j	.L63
.L65:
	ld	a5,-24(s0)
	ld	a5,0(a5)
.L63:
	mv	a0,a5
	ld	s0,40(sp)
	addi	sp,sp,48
	jr	ra
	.size	linked_list_at, .-linked_list_at
	.align	1
	.globl	hash_table_get_string
	.type	hash_table_get_string, @function
hash_table_get_string:
	addi	sp,sp,-48
	sd	ra,40(sp)
	sd	s0,32(sp)
	addi	s0,sp,48
	sd	a0,-24(s0)
	sd	a1,-40(s0)
	sd	a2,-32(s0)
	ld	a0,-40(s0)
	ld	a1,-32(s0)
	call	strhash
	mv	a5,a0
	mv	a1,a5
	ld	a0,-24(s0)
	call	hash_table_get
	mv	a5,a0
	mv	a0,a5
	ld	ra,40(sp)
	ld	s0,32(sp)
	addi	sp,sp,48
	jr	ra
	.size	hash_table_get_string, .-hash_table_get_string
	.section	.rodata
	.align	3
.LC0:
	.word	0
	.word	1083129856
	.ident	"GCC: () 13.2.0"
