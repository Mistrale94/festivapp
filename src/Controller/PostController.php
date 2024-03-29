<?php

namespace App\Controller;

use App\Entity\Post;
use App\Form\PostType;
use App\Repository\PostRepository;
use App\Entity\Comment;
use App\Form\CommentType;
use App\Repository\CommentRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\Persistence\ManagerRegistry as PersistenceManagerRegistry;

#[Route('/')]
class PostController extends AbstractController
{

    private $repo;

    public function __construct(PostRepository $repo)
    {
        $this->repo = $repo;
    }

    #[Route('/', name: 'app_post_index', methods: ['GET', 'POST'])]
    public function index(PostRepository $postRepository, CommentRepository $commentRepository, Request $request): Response
    {
        $user = $this->getUser();
        $comment = new Comment();
        $comment->setUser($user);
        $form = $this->createForm(CommentType::class, $comment);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $commentRepository->add($comment, true);

            return $this->redirectToRoute('app_post_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('post/index.html.twig', [
            'posts' => $postRepository->findAll(),
            'comment' => $comment,
            'form' => $form,
        ]);
    }

    #[Route('/like', name: 'like', methods: ['POST'])]
    public function like(Request $request, PersistenceManagerRegistry $doctrine): Response
    {
        $id = $request->request->all();
        $post = $this->repo->find(intval($id['id']));
        $user = $this->getUser();
        $user->addLike($post);

        $entityManager = $doctrine->getManager();
        $entityManager->persist($post);
        $entityManager->persist($user);
        $entityManager->flush();

        return $this->redirectToRoute('app_post_index');
    }

    #[Route('/unlike', name: 'unlike', methods: ['POST'])]
    public function unlike(Request $request, PersistenceManagerRegistry $doctrine): Response
    {
        $id = $request->request->all();
        $post = $this->repo->find(intval($id['id']));
        $user = $this->getUser();
        $user->removeLike($post);

        $entityManager = $doctrine->getManager();
        $entityManager->persist($post);
        $entityManager->persist($user);
        $entityManager->flush();

        return $this->redirectToRoute('app_post_index');
    }

    #[Route('/new', name: 'app_post_new', methods: ['GET', 'POST'])]
    public function new(Request $request, PostRepository $postRepository): Response
    {
        $user = $this->getUser();
        $post = new Post();
        $post->setUser($user);
        $form = $this->createForm(PostType::class, $post);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $postRepository->add($post, true);

            return $this->redirectToRoute('app_post_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('post/new.html.twig', [
            'post' => $post,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_post_show', methods: ['GET'])]
    public function show(Post $post): Response
    {
        return $this->render('post/show.html.twig', [
            'post' => $post,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_post_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Post $post, PostRepository $postRepository): Response
    {
        $form = $this->createForm(PostType::class, $post);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $postRepository->add($post, true);

            return $this->redirectToRoute('app_post_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('post/edit.html.twig', [
            'post' => $post,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_post_delete', methods: ['POST'])]
    public function delete(Request $request, Post $post, PostRepository $postRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$post->getId(), $request->request->get('_token'))) {
            $postRepository->remove($post, true);
        }

        return $this->redirectToRoute('app_post_index', [], Response::HTTP_SEE_OTHER);
    }
}
