<?php
declare(strict_types=1);

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\ControllerTrait;
use Symfony\Component\HttpFoundation\Response;

final class DefaultController
{
    use ControllerTrait;

    public function index()
    {
        return new Response('Hello world');
    }
}
