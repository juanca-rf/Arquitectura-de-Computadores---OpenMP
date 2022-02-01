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
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	subq	$64, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	cmpl	$2, %edi
	jle	.L16
	movq	8(%rsi), %rdi
	movl	$10, %edx
	movq	%rsi, %r12
	xorl	%esi, %esi
	call	strtol@PLT
	movq	16(%r12), %rdi
	xorl	%esi, %esi
	movq	%rax, %rbx
	movl	%eax, %ebp
	call	strtod@PLT
	movslq	%ebx, %r13
	salq	$3, %r13
	movsd	%xmm0, 8(%rsp)
	movq	%r13, %rdi
	call	malloc@PLT
	movq	%r13, %rdi
	movq	%rax, %r12
	call	malloc@PLT
	movq	%rax, %r14
	testl	%ebx, %ebx
	jle	.L4
	leal	-1(%rbx), %r13d
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L5:
	call	rand@PLT
	pxor	%xmm0, %xmm0
	cltd
	idivl	%ebp
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, (%r12,%rbx,8)
	call	rand@PLT
	pxor	%xmm0, %xmm0
	cltd
	idivl	%ebp
	movq	%rbx, %rax
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, (%r14,%rbx,8)
	addq	$1, %rbx
	cmpq	%rax, %r13
	jne	.L5
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L7:
	movsd	8(%rsp), %xmm0
	mulsd	(%r12,%rax,8), %xmm0
	movq	%rax, %rdx
	addsd	(%r14,%rax,8), %xmm0
	movsd	%xmm0, (%r14,%rax,8)
	addq	$1, %rax
	cmpq	%rdx, %r13
	jne	.L7
.L8:
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
	jne	.L17
	addq	$64, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
.L16:
	.cfi_restore_state
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	call	__printf_chk@PLT
	jmp	.L3
.L4:
	leaq	16(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	jmp	.L8
.L17:
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
