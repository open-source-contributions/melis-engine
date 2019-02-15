<?php

/**
 * Melis Technology (http://www.melistechnology.com)
 *
 * @copyright Copyright (c) 2015 Melis Technology (http://www.melistechnology.com)
 *
 */

namespace MelisEngine\Controller;

use Zend\Mvc\Controller\AbstractActionController;
use Zend\View\Model\JsonModel;
use Zend\View\Model\ViewModel;
use MelisCore\MelisSetupInterface;

/**
 * @property bool $showOnMarketplacePostSetup
 */
class MelisSetupPostUpdateController extends AbstractActionController implements MelisSetupInterface
{
    /**
     * flag for Marketplace whether to display the setup form or not
     * @var bool $showOnMarketplacePostSetup
     */
    public $showOnMarketplacePostSetup = true;

    /**
     * @return \Zend\View\Model\ViewModel
     */
    public function getFormAction()
    {
        $view = new ViewModel();
        $view->setTerminal(true);

        return $view;
    }

    /**
     * @return \Zend\View\Model\JsonModel
     */
    public function validateFormAction()
    {
        return new JsonModel([]);
    }

    /**
     * @return \Zend\View\Model\JsonModel
     */
    public function submitAction()
    {
        return new JsonModel([]);
    }

}