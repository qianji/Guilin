/*
 * Copyright 2014 guilin. All rights reserved.
 * Support: guilin
 * License: guilin
 */
package gov.guilin.service;

import gov.guilin.entity.MemberAttribute;

import java.util.List;


/**
 * Service - 会员注册项
 * 
 * @author guilin
 * @version
 */
public interface MemberAttributeService extends BaseService<MemberAttribute, Long> {

	/**
	 * 查找未使用的对象属性序号
	 * 
	 * @return 未使用的对象属性序号，若无可用序号则返回null
	 */
	Integer findUnusedPropertyIndex();

	/**
	 * 查找会员注册项
	 * 
	 * @return 会员注册项，仅包含已启用会员注册项
	 */
	List<MemberAttribute> findList();

	/**
	 * 查找会员注册项(缓存)
	 * 
	 * @param cacheRegion
	 *            缓存区域
	 * @return 会员注册项(缓存)，仅包含已启用会员注册项
	 */
	List<MemberAttribute> findList(String cacheRegion);

}