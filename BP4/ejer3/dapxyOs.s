	.file	"dapxy.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Falta tama\303\261o y constante"
.LC2:
	.string	"DAXPY Tiempo ejecucion %11.9f\n"
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$72, %rsp
	.cfi_def_cfa_offset 112
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	cmpl	$2, %edi
	jg	.L2
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	call	__printf_chk@PLT
	jmp	.L3
.L2:
	movq	8(%rsi), %rdi
	movq	%rsi, %rbp
	xorl	%r12d, %r12d
	call	atoi@PLT
	movq	16(%rbp), %rdi
	movl	%eax, %ebx
	call	atof@PLT
	movslq	%ebx, %rbp
	salq	$3, %rbp
	movsd	%xmm0, 8(%rsp)
	movq	%rbp, %rdi
	call	malloc@PLT
	movq	%rbp, %rdi
	movq	%rax, %r13
	call	malloc@PLT
	movq	%rax, %rbp
.L4:
	cmpl	%r12d, %ebx
	jle	.L11
	call	rand@PLT
	cltd
	idivl	%ebx
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, 0(%r13,%r12,8)
	call	rand@PLT
	cltd
	idivl	%ebx
	cvtsi2sdl	%edx, %xmm0
	movsd	%xmm0, 0(%rbp,%r12,8)
	incq	%r12
	jmp	.L4
.L11:
	leaq	24(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	xorl	%eax, %eax
.L6:
	cmpl	%eax, %ebx
	jle	.L12
	movsd	8(%rsp), %xmm0
	mulsd	0(%r13,%rax,8), %xmm0
	addsd	0(%rbp,%rax,8), %xmm0
	movsd	%xmm0, 0(%rbp,%rax,8)
	incq	%rax
	jmp	.L6
.L12:
	leaq	40(%rsp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	48(%rsp), %rax
	subq	32(%rsp), %rax
	leaq	.LC2(%rip), %rsi
	cvtsi2sdq	%rax, %xmm0
	movq	40(%rsp), %rax
	subq	24(%rsp), %rax
	divsd	.LC1(%rip), %xmm0
	cvtsi2sdq	%rax, %xmm1
	movl	$1, %edi
	movb	$1, %al
	addsd	%xmm1, %xmm0
	call	__printf_chk@PLT
.L3:
	movq	56(%rsp), %rax
	xorq	%fs:40, %rax
	je	.L8
	call	__stack_chk_fail@PLT
.L8:
	addq	$72, %rsp
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
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
