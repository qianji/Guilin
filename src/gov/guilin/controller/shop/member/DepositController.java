/*
 * Copyright 2014 guilin. All rights reserved.
 * Support: guilin
 * License: guilin
 */
package gov.guilin.controller.shop.member;

import gov.guilin.Pageable;
import gov.guilin.controller.shop.BaseController;
import gov.guilin.entity.Member;
import gov.guilin.plugin.PaymentPlugin;
import gov.guilin.service.DepositService;
import gov.guilin.service.MemberService;
import gov.guilin.service.PluginService;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;


import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Controller - 会员中心 - 预存款
 * 
 * @author guilin
 * @version
 */
@Controller("shopMemberDepositController")
@RequestMapping("/member/deposit")
public class DepositController extends BaseController {

	/** 每页记录数 */
	private static final int PAGE_SIZE = 10;

	@Resource(name = "memberServiceImpl")
	private MemberService memberService;
	@Resource(name = "depositServiceImpl")
	private DepositService depositService;
	@Resource(name = "pluginServiceImpl")
	private PluginService pluginService;

	/**
	 * 计算支付手续费
	 */
	@RequestMapping(value = "/calculate_fee", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> calculateFee(String paymentPluginId, BigDecimal amount) {
		Map<String, Object> data = new HashMap<String, Object>();
		PaymentPlugin paymentPlugin = pluginService.getPaymentPlugin(paymentPluginId);
		if (paymentPlugin == null || !paymentPlugin.getIsEnabled() || amount == null || amount.compareTo(new BigDecimal(0)) < 0) {
			data.put("message", ERROR_MESSAGE);
			return data;
		}
		data.put("message", SUCCESS_MESSAGE);
		data.put("fee", paymentPlugin.calculateFee(amount));
		return data;
	}

	/**
	 * 检查余额
	 */
	@RequestMapping(value = "/check_balance", method = RequestMethod.POST)
	public @ResponseBody
	Map<String, Object> checkBalance() {
		Map<String, Object> data = new HashMap<String, Object>();
		Member member = memberService.getCurrent();
		data.put("balance", member.getBalance());
		return data;
	}

	/**
	 * 充值
	 */
	@RequestMapping(value = "/recharge", method = RequestMethod.GET)
	public String recharge(ModelMap model) {
		List<PaymentPlugin> paymentPlugins = pluginService.getPaymentPlugins(true);
		if (!paymentPlugins.isEmpty()) {
			model.addAttribute("defaultPaymentPlugin", paymentPlugins.get(0));
			model.addAttribute("paymentPlugins", paymentPlugins);
		}
		return "shop/member/deposit/recharge";
	}

	/**
	 * 列表
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Integer pageNumber, ModelMap model) {
		Member member = memberService.getCurrent();
		Pageable pageable = new Pageable(pageNumber, PAGE_SIZE);
		model.addAttribute("page", depositService.findPage(member, pageable));
		return "shop/member/deposit/list";
	}

}