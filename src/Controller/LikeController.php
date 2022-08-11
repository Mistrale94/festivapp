<?php

namespace App\Controller;

use App\Entity\Like;
use App\Form\LikeType;
use App\Repository\LikeRepository;
use App\Repository\PostRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\Persistence\ManagerRegistry as PersistenceManagerRegistry;

#[Route('/like')]
class LikeController extends AbstractController
{

    #[Route('/', name: 'app_like_index', methods: ['GET'])]
    public function index(LikeRepository $likeRepository): Response
    {
        return $this->render('like/index.html.twig', [
            'likes' => $likeRepository->findAll(),
        ]);
    }

    #[Route('/like', name: 'like', methods: ['POST'])]
    public function like(Request $request, PostRepository $postRepository, PersistenceManagerRegistry $doctrine): Response
    {

        $like = new Like();
        $data = $request->request->all();
        $user = $this->getUser();
        $like->setUser($user);
        $like->setLove(true);
        $post = $postRepository->find(intval($data['id']));
        $post->addLove($like);
        $post->setLikes($post->getLikes() + 1);
        $entityManager = $doctrine->getManager();
        $entityManager->persist($user);
        $entityManager->persist($like);
        $entityManager->persist($post);
        $entityManager->flush();

        return $this->redirectToRoute('app_post_index', [
            'like' => $like,
        ]);
    }

    #[Route('/new', name: 'app_like_new', methods: ['GET', 'POST'])]
    public function new(Request $request, LikeRepository $likeRepository): Response
    {
        $like = new Like();
        $form = $this->createForm(LikeType::class, $like);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $likeRepository->add($like, true);

            return $this->redirectToRoute('app_like_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('like/new.html.twig', [
            'like' => $like,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_like_show', methods: ['GET'])]
    public function show(Like $like): Response
    {
        return $this->render('like/show.html.twig', [
            'like' => $like,
        ]);
    }

    #[Route('/{id}/edit', name: 'app_like_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Like $like, LikeRepository $likeRepository): Response
    {
        $form = $this->createForm(LikeType::class, $like);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $likeRepository->add($like, true);

            return $this->redirectToRoute('app_like_index', [], Response::HTTP_SEE_OTHER);
        }

        return $this->renderForm('like/edit.html.twig', [
            'like' => $like,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'app_like_delete', methods: ['POST'])]
    public function delete(Request $request, Like $like, LikeRepository $likeRepository): Response
    {
        if ($this->isCsrfTokenValid('delete'.$like->getId(), $request->request->get('_token'))) {
            $likeRepository->remove($like, true);
        }

        return $this->redirectToRoute('app_like_index', [], Response::HTTP_SEE_OTHER);
    }
}
