	.text
	.globl main
print_int:
	pushq %rbp
	movq %rsp, %rbp
	addq $-16, %rsp
	movq %r12, -8(%rbp)
	movq %rbx, -16(%rbp)
	movq %rdi, %r12
	movq $10, %rdi
	movq %r12, %rbx
	movq %rbx, %rax
	cqto
	idivq %rdi
	movq %rax, %rbx
	movq %rbx, %rdi
	movq $9, %rdi
	movq %r12, %rcx
	cmpq %rdi, %rcx
	setg %cl
	movzbq %cl, %rcx
	cmpq $0, %rcx
	jz L10
	movq %rbx, %rdi
	call print_int
L10:
	movq %rbx, %rax
	movq $10, %rdi
	imulq %rax, %rdi
	movq %r12, %rcx
	subq %rdi, %rcx
	movq $48, %rdi
	addq %rcx, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %r12
	movq -16(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	jmp L10
supprimer:
	pushq %rbp
	movq %rsp, %rbp
	movq 16(%rdi), %rsi
	movq 8(%rdi), %rcx
	movq %rsi, 16(%rcx)
	movq %rdi, %rsi
	movq 8(%rsi), %rax
	movq 16(%rdi), %rdi
	movq %rax, 8(%rdi)
	movq $0, %rax
	popq %rbp
	ret
afficher:
	pushq %rbp
	movq %rsp, %rbp
	addq $-16, %rsp
	movq %rbx, -8(%rbp)
	movq %rdi, -16(%rbp)
	movq -16(%rbp), %rbx
	movq 0(%rbx), %rdi
	call putchar
	movq %rbx, %rax
	movq 16(%rax), %rbx
	movq %rbx, %rcx
L51:
	movq -16(%rbp), %rcx
	movq %rbx, %rdi
	cmpq %rcx, %rdi
	setne %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L39
	movq 0(%rbx), %rdi
	call putchar
	movq %rbx, %rax
	movq 16(%rax), %rdi
	movq %rdi, %rbx
	movq %rbx, %rdi
	jmp L51
L39:
	movq $10, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
cercle:
	pushq %rbp
	movq %rsp, %rbp
	addq $-24, %rsp
	movq %rdi, -8(%rbp)
	movq $1, %rdi
	call make
	movq %rax, -24(%rbp)
	movq -24(%rbp), %rdi
	movq -8(%rbp), %rdi
	movq %rdi, -16(%rbp)
	movq -16(%rbp), %rcx
L76:
	movq $2, %rcx
	movq -16(%rbp), %rdi
	cmpq %rcx, %rdi
	setge %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L63
	movq -16(%rbp), %rcx
	movq -24(%rbp), %rdi
	movq %rcx, %rsi
	call inserer_apres
	movq $1, %rax
	movq -16(%rbp), %rdi
	subq %rax, %rdi
	movq %rdi, -16(%rbp)
	jmp L76
L63:
	movq -24(%rbp), %r15
	movq %r15, -16(%rbp)
	movq -16(%rbp), %rax
	movq %rbp, %rsp
	popq %rbp
	ret
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $5, %rcx
	movq $7, %rdi
	movq %rcx, %rsi
	call josephus
	movq %rax, %rdi
	call print_int
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq %rax, %rcx
	movq $5, %rcx
	movq $5, %rdi
	movq %rcx, %rsi
	call josephus
	movq %rax, %rdi
	call print_int
	movq %rax, %rdi
	movq $10, %rdi
	call putchar
	movq %rax, %rsi
	movq $17, %rsi
	movq $5, %rdi
	call josephus
	movq %rax, %rdi
	call print_int
	movq %rax, %rdi
	movq $10, %rdi
	call putchar
	movq %rax, %rsi
	movq $2, %rsi
	movq $13, %rdi
	call josephus
	movq %rax, %rdi
	call print_int
	movq %rax, %rdi
	movq $10, %rdi
	call putchar
	movq %rax, %rdi
	movq $0, %rdi
	movq %rdi, %rax
	popq %rbp
	ret
josephus:
	pushq %rbp
	movq %rsp, %rbp
	addq $-16, %rsp
	movq %rsi, -16(%rbp)
	call cercle
	movq %rax, -8(%rbp)
L140:
	movq -8(%rbp), %r15
	movq 16(%r15), %rcx
	movq -8(%rbp), %rdi
	cmpq %rcx, %rdi
	setne %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L112
	movq $1, %rdi
	movq %rdi, %rsi
L132:
	movq -16(%rbp), %rsi
	movq %rdi, %rcx
	cmpq %rsi, %rcx
	jl L129
	movq -8(%rbp), %rdi
	call supprimer
	movq -8(%rbp), %rax
	movq 16(%rax), %r15
	movq %r15, -8(%rbp)
	movq -8(%rbp), %rdi
	jmp L140
L129:
	movq -8(%rbp), %rcx
	movq 16(%rcx), %r15
	movq %r15, -8(%rbp)
	movq -8(%rbp), %rcx
	movq $1, %rcx
	addq %rcx, %rdi
	jmp L132
L112:
	movq -8(%rbp), %rdi
	movq 0(%rdi), %rax
	movq %rbp, %rsp
	popq %rbp
	ret
make:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq %rdi, %rbx
	movq $24, %rdi
	call sbrk
	movq %rax, %rdi
	movq %rdi, %rcx
	movq %rbx, %rcx
	movq %rcx, 0(%rdi)
	movq %rdi, %rcx
	movq %rcx, 8(%rdi)
	movq %rcx, 16(%rdi)
	movq %rdi, %rcx
	movq %rcx, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
inserer_apres:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %r12, -8(%rbp)
	movq %rsi, %rcx
	movq %rdi, %r12
	movq %rcx, %rdi
	call make
	movq %rax, %rdi
	movq %r12, %rdi
	movq 16(%rdi), %rdi
	movq %rdi, 16(%rax)
	movq %rax, %rdi
	movq %rdi, 16(%r12)
	movq %rax, %rdi
	movq 16(%rax), %rcx
	movq %rdi, 8(%rcx)
	movq %r12, %rdi
	movq %rdi, 8(%rax)
	movq $0, %rdi
	movq %rdi, %rax
	movq -8(%rbp), %r12
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
