	.file	"dapxy.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Falta tama\303\261o y constante"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC2:
	.string	"DAXPY Tiempo ejecucion %11.9f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$72, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	cmpl	$2, %edi
	jle	.L17
	movq	8(%rsi), %rdi
	movl	$10, %edx
	movq	%rsi, %rbx
	xorl	%esi, %esi
	call	strtol@PLT
	movq	16(%rbx), %rdi
	xorl	%esi, %esi
	movq	%rax, %r12
	movl	%eax, %ebp
	call	strtod@PLT
	movslq	%r12d, %r14
	salq	$3, %r14
	movsd	%xmm0, 8(%rsp)
	movq	%r14, %rdi
	call	malloc@PLT
	movq	%r14, %rdi
	movq	%rax, %r13
	call	malloc@PLT
	movq	%rax, %r15
	testl	%r12d, %r12d
	jle	.L4
	leal	-1(%r12), %r14d
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L5:
	call	rand@PLT
	pxor	%xmm0, %xmm0
	cltd
	idivl	%ebp
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, 0(%r13,%rbx,8)
	call	rand@PLT
	pxor	%xmm0, %xmm0
	cltd
	idivl	%ebp
	movq	%rbx, %rax
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, (%r15,%rbx,8)
	addq	$1, %rbx
	cmpq	%r14, %rax
	jne	.L5
	xorl	%edi, %edi
	leaq	16(%rsp), %rsi
	call	clock_gettime@PLT
	cmpl	$1, %r12d
	je	.L9
	movsd	8(%rsp), %xmm1
	shrl	%r12d
	xorl	%edx, %edx
	salq	$4, %r12
	unpcklpd	%xmm1, %xmm1
	.p2align 4,,10
	.p2align 3
.L7:
	movupd	0(%r13,%rdx), %xmm0
	movupd	(%r15,%rdx), %xmm2
	mulpd	%xmm1, %xmm0
	addpd	%xmm2, %xmm0
	movups	%xmm0, (%r15,%rdx)
	addq	$16, %rdx
	cmpq	%rdx, %r12
	jne	.L7
.L9:
	leaq	32(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	40(%rsp), %rax
	pxor	%xmm0, %xmm0
	subq	24(%rsp), %rax
	cvtsi2sdq	%rax, %xmm0
	pxor	%xmm1, %xmm1
	movq	32(%rsp), %rax
	subq	16(%rsp), %rax
	cvtsi2sdq	%rax, %xmm1
	movl	$1, %edi
	movl	$1, %eax
	divsd	.LC1(%rip), %xmm0
	leaq	.LC2(%rip), %rsi
	addsd	%xmm1, %xmm0
	call	__printf_chk@PLT
.L3:
	movq	56(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L18
	addq	$72, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L17:
	.cfi_restore_state
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	call	__printf_chk@PLT
	jmp	.L3
.L4:
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	jmp	.L9
.L18:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	0
	.long	1104006501
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
