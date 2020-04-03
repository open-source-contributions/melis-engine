<?php

/**
 * @see       https://github.com/laminas/laminas-mvc for the canonical source repository
 * @copyright https://github.com/laminas/laminas-mvc/blob/master/COPYRIGHT.md
 * @license   https://github.com/laminas/laminas-mvc/blob/master/LICENSE.md New BSD License
 */

namespace MelisEngine\Controller;

use Laminas\Mvc\Controller\AbstractActionController as AbstractController;

/**
 * Basic action controller
 */
abstract class AbstractActionController extends AbstractController
{
    protected $serviceManager = null;

    public function getServiceManager()
    {
        $this->serviceManager = $this->serviceManager ?: $this->getEvent()->getApplication()->getServiceManager();
        return $this->serviceManager;
    }
}