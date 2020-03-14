	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq %r12, %rcx
	movq $16, %rax
	call sbrk
	movq $24, %rax
	call sbrk
	movq $16, %rax
	call sbrk
	movq %rax, %rsi
	movq %rsi, 8(%rax)
	movq $65, %rsi
	movq %rsi, 0(%rax)
	movq $66, %rsi
	movq %rax, %rbx
	movq %rsi, 16(%rbx)
	movq $120, %rsi
	movq 8(%rax), %rbx
	movq %rsi, 0(%rbx)
	movq $121, %rsi
	movq 8(%rax), %rbx
	movq %rsi, 8(%rbx)
	movq %rax, %rsi
	movq 0(%rsi), %rsi
	movq %rsi, %rax
	call putchar
	movq 8(%rax), %rsi
	movq 0(%rsi), %rsi
	movq %rsi, %rax
	call putchar
	movq 8(%rax), %rsi
	movq 8(%rsi), %rsi
	movq %rsi, %rax
	call putchar
	movq 16(%rax), %rsi
	movq %rsi, %rax
	call putchar
	movq $10, %rax
	call putchar
	movq $88, %rax
	movq %rax, 0(%rax)
	movq $89, %rax
	movq %rax, 8(%rax)
	movq 0(%rax), %rsi
	movq %rsi, %rax
	call putchar
	movq 8(%rax), %rsi
	movq 0(%rsi), %rsi
	movq %rsi, %rax
	call putchar
	movq 8(%rax), %rsi
	movq 8(%rsi), %rsi
	movq %rsi, %rax
	call putchar
	movq 16(%rax), %rax
	call putchar
	movq $10, %rax
	call putchar
	movq %rax, 8(%rax)
	movq 0(%rax), %rax
	call putchar
	movq 8(%rax), %rsi
	movq 0(%rsi), %rax
	call putchar
	movq %rax, %rsi
	movq %rax, %rsi
	movq 8(%rsi), %rsi
	movq 8(%rsi), %rsi
	movq %rsi, %rax
	call putchar
	movq 16(%rax), %rsi
	movq %rsi, %rax
	call putchar
	movq $10, %rax
	call putchar
	movq $0, %rax
	movq %rcx, %r12
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
