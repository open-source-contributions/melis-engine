<?php

/**
 * Melis Technology (http://www.melistechnology.com)
 *
 * @copyright Copyright (c) 2016 Melis Technology (http://www.melistechnology.com)
 *
 */

namespace MelisEngine\Service\Factory;

use Zend\ServiceManager\ServiceLocatorInterface;
use Zend\ServiceManager\FactoryInterface;
use MelisEngine\Service\MelisSearchService;

class MelisSearchServiceFactory implements FactoryInterface
{
	public function createService(ServiceLocatorInterface $sl)
	{ 
		$melisSearchService = new \MelisEngine\Service\MelisSearchService();
		$melisSearchService->setServiceLocator($sl);
		 
		return $melisSearchService;
	}

}