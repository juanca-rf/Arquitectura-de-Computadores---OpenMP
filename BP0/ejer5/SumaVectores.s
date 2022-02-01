	.file	"SumaVectores.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"Faltan n\302\272 componentes del vector"
	.align 8
.LC2:
	.string	"/ V1[%d]+V2[%d]=V3[%d](%8.6f+%8.6f=%8.6f) /\n"
	.align 8
.LC3:
	.string	"Tiempo:%11.9f\t / Tama\303\261o Vectores:%u\t/ V1[0]+V2[0]=V3[0](%8.6f+%8.6f=%8.6f) / / V1[%d]+V2[%d]=V3[%d](%8.6f+%8.6f=%8.6f) /\n"
	.align 8
.LC4:
	.string	"Tiempo:%11.9f\t / Tama\303\261o Vectores:%u\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$104, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%fs:40, %rax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	cmpl	$1, %edi
	jle	.L42
	movq	8(%rsi), %rdi
	movl	$10, %edx
	xorl	%esi, %esi
	call	strtol@PLT
	movq	%rsp, %rsi
	movq	%rax, %r13
	movl	%eax, %ebx
	movl	%eax, %eax
	leaq	15(,%rax,8), %rdx
	movq	%rdx, %rax
	shrq	$4, %rax
	salq	$4, %rax
	movq	%rax, %rcx
	andq	$-4096, %rcx
	subq	%rcx, %rsi
	movq	%rsi, %rcx
	cmpq	%rcx, %rsp
	je	.L4
.L43:
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	cmpq	%rcx, %rsp
	jne	.L43
.L4:
	andl	$4095, %eax
	subq	%rax, %rsp
	testq	%rax, %rax
	jne	.L44
.L5:
	leaq	7(%rsp), %r10
	movq	%rsp, %rdi
	movq	%r10, %rax
	andq	$-8, %r10
	shrq	$3, %rax
	movq	%r10, %r15
	movq	%rax, -128(%rbp)
	movq	%rdx, %rax
	shrq	$4, %rax
	salq	$4, %rax
	movq	%rax, %rcx
	andq	$-4096, %rcx
	subq	%rcx, %rdi
	movq	%rdi, %rcx
.L6:
	cmpq	%rcx, %rsp
	je	.L7
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L6
.L44:
	orq	$0, -8(%rsp,%rax)
	jmp	.L5
.L7:
	andl	$4095, %eax
	subq	%rax, %rsp
	testq	%rax, %rax
	jne	.L45
.L8:
	leaq	7(%rsp), %r11
	shrq	$4, %rdx
	movq	%rsp, %rsi
	movq	%r11, %rax
	salq	$4, %rdx
	andq	$-8, %r11
	shrq	$3, %rax
	movq	%r11, %r12
	movq	%rax, -136(%rbp)
	movq	%rdx, %rax
	andq	$-4096, %rax
	subq	%rax, %rsi
	movq	%rsi, %rax
.L9:
	cmpq	%rax, %rsp
	je	.L10
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L9
.L45:
	orq	$0, -8(%rsp,%rax)
	jmp	.L8
.L10:
	andl	$4095, %edx
	subq	%rdx, %rsp
	testq	%rdx, %rdx
	je	.L11
	orq	$0, -8(%rsp,%rdx)
.L11:
	leaq	7(%rsp), %rax
	movq	%rax, %rsi
	andq	$-8, %rax
	shrq	$3, %rsi
	movq	%rax, -104(%rbp)
	movq	%rsi, -144(%rbp)
	cmpl	$8, %r13d
	ja	.L12
	testl	%r13d, %r13d
	je	.L13
	pxor	%xmm1, %xmm1
	movsd	.LC1(%rip), %xmm3
	xorl	%eax, %eax
	cvtsi2sdl	%r13d, %xmm1
	mulsd	%xmm3, %xmm1
	.p2align 4,,10
	.p2align 3
.L14:
	pxor	%xmm0, %xmm0
	movapd	%xmm1, %xmm2
	movapd	%xmm1, %xmm7
	cvtsi2sdl	%eax, %xmm0
	mulsd	%xmm3, %xmm0
	addsd	%xmm0, %xmm2
	subsd	%xmm0, %xmm7
	movsd	%xmm2, (%r15,%rax,8)
	movsd	%xmm7, (%r12,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %ebx
	ja	.L14
.L15:
	leaq	-96(%rbp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L17:
	movsd	(%r15,%rax,8), %xmm0
	addsd	(%r12,%rax,8), %xmm0
	movq	-104(%rbp), %rcx
	movsd	%xmm0, (%rcx,%rax,8)
	addq	$1, %rax
	cmpl	%eax, %ebx
	ja	.L17
	leaq	-80(%rbp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	-72(%rbp), %rax
	pxor	%xmm0, %xmm0
	subq	-88(%rbp), %rax
	cvtsi2sdq	%rax, %xmm0
	pxor	%xmm1, %xmm1
	movq	-80(%rbp), %rax
	subq	-96(%rbp), %rax
	cvtsi2sdq	%rax, %xmm1
	divsd	.LC5(%rip), %xmm0
	addsd	%xmm1, %xmm0
	cmpl	$9, %r13d
	jbe	.L46
	movq	-104(%rbp), %rbx
	leal	-1(%r13), %eax
	movl	%r13d, %edx
	movl	$1, %edi
	movsd	(%r12,%rax,8), %xmm5
	movq	%rax, %rcx
	movl	%eax, %r9d
	movl	%eax, %r8d
	movsd	(%rbx,%rax,8), %xmm6
	movsd	(%r15,%rax,8), %xmm4
	leaq	.LC3(%rip), %rsi
	movq	-144(%rbp), %rax
	movsd	0(,%rax,8), %xmm3
	movq	-136(%rbp), %rax
	movsd	0(,%rax,8), %xmm2
	movq	-128(%rbp), %rax
	movsd	0(,%rax,8), %xmm1
	movl	$7, %eax
	call	__printf_chk@PLT
.L20:
	movq	-56(%rbp), %rax
	xorq	%fs:40, %rax
	jne	.L47
	leaq	-40(%rbp), %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L46:
	.cfi_restore_state
	movl	%r13d, %edx
	movl	$1, %edi
	movl	$1, %eax
	xorl	%r14d, %r14d
	leaq	.LC4(%rip), %rsi
	leaq	.LC2(%rip), %r13
	call	__printf_chk@PLT
	.p2align 4,,10
	.p2align 3
.L19:
	movq	-104(%rbp), %rax
	movsd	(%r15,%r14,8), %xmm0
	movl	%r14d, %r8d
	movl	%r14d, %ecx
	movsd	(%r12,%r14,8), %xmm1
	movl	%r14d, %edx
	movq	%r13, %rsi
	movl	$1, %edi
	movsd	(%rax,%r14,8), %xmm2
	movl	$3, %eax
	addq	$1, %r14
	call	__printf_chk@PLT
	cmpl	%r14d, %ebx
	ja	.L19
	jmp	.L20
.L12:
	xorl	%edi, %edi
	xorl	%r14d, %r14d
	call	time@PLT
	movq	%rax, %rdi
	call	srand@PLT
	leal	-1(%r13), %eax
	movq	%rax, -120(%rbp)
	.p2align 4,,10
	.p2align 3
.L16:
	call	rand@PLT
	movl	%eax, -108(%rbp)
	call	rand@PLT
	movl	-108(%rbp), %edx
	pxor	%xmm0, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%eax, %xmm1
	cvtsi2sdl	%edx, %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%r15,%r14,8)
	call	rand@PLT
	movl	%eax, -108(%rbp)
	call	rand@PLT
	movl	-108(%rbp), %edx
	pxor	%xmm0, %xmm0
	pxor	%xmm1, %xmm1
	cvtsi2sdl	%eax, %xmm1
	movq	%r14, %rax
	cvtsi2sdl	%edx, %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, (%r12,%r14,8)
	addq	$1, %r14
	cmpq	%rax, -120(%rbp)
	jne	.L16
	jmp	.L15
.L13:
	leaq	-96(%rbp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	leaq	-80(%rbp), %rsi
	xorl	%edi, %edi
	call	clock_gettime@PLT
	movq	-72(%rbp), %rax
	pxor	%xmm0, %xmm0
	xorl	%edx, %edx
	subq	-88(%rbp), %rax
	pxor	%xmm1, %xmm1
	movl	$1, %edi
	cvtsi2sdq	%rax, %xmm0
	movq	-80(%rbp), %rax
	subq	-96(%rbp), %rax
	divsd	.LC5(%rip), %xmm0
	cvtsi2sdq	%rax, %xmm1
	leaq	.LC4(%rip), %rsi
	movl	$1, %eax
	addsd	%xmm1, %xmm0
	call	__printf_chk@PLT
	jmp	.L20
.L42:
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	orl	$-1, %edi
	call	exit@PLT
.L47:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE39:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	2576980378
	.long	1069128089
	.align 8
.LC5:
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
