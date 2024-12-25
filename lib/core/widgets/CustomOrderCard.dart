

import 'package:flutter/material.dart';

class CustomOrderCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isShow;
  final Function(String)? onDetailTap;
  final Function(String)? onPhoneTap;

  const CustomOrderCard({
    Key? key,
    required this.data,
    this.isShow = false,
    this.onDetailTap,
    this.onPhoneTap,
  }) : super(key: key);

  // 构建单行方法
  Widget _buildRow(String label, String? value, {bool isLink = false, Function()? onTap}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          GestureDetector(
            onTap: isLink ? onTap : null,
            child: Text(
              value ?? '-',
              style: TextStyle(
                fontSize: 14,
                color: isLink ? Colors.blue : Colors.black,
                decoration: isLink ? TextDecoration.underline : TextDecoration.none,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('Created At', data['createTime']), // 创建时间
            _buildRow(
              'Cabinet No.',
              data['cabinetEntity']?['ueSn'],
              isLink: true,
              onTap: () => onDetailTap?.call(data['cabinetEntity']?['ueSn']),
            ), // 电柜号
            _buildRow('Cabinet Alias', data['cabinetEntity']?['name']), // 电柜别名
            if (isShow)
              _buildRow(
                'Affiliated Channel',
                '${data['adminName'] ?? '-'} / ${data['agentName'] ?? '-'} / ${data['dealerName'] ?? '-'} / ${data['storeName'] ?? '-'}',
              ), // 归属渠道
            if (isShow) _buildRow('Site', data['shopName']), // 站点
            _buildRow('User', data['userEntity']?['realname'] ?? data['userName']), // 用户
            _buildRow(
              'Contact',
              data['userEntity']?['phoneNumber'],
              isLink: true,
              onTap: () => onPhoneTap?.call(data['userEntity']?['phoneNumber']),
            ), // 联系方式
            _buildRow(
              'Original Battery',
              data['cabinetTaskDetailDto']?['returnUeSn'],
              isLink: true,
              onTap: () => onDetailTap?.call(data['cabinetTaskDetailDto']?['returnUeSn']),
            ), // 原电池
            _buildRow('Original Battery SOC', '${data['cabinetTaskDetailDto']?['returnBatterySoc'] ?? '-'}%'), // 原电池SOC
            _buildRow(
              'New Battery',
              data['cabinetTaskDetailDto']?['takeBattery'],
              isLink: true,
              onTap: () => onDetailTap?.call(data['cabinetTaskDetailDto']?['takeBattery']),
            ), // 新电池
            _buildRow('New Battery SOC', '${data['cabinetTaskDetailDto']?['takeBatterySoc'] ?? '-'}%'), // 新电池SOC
            _buildRow('Start Time', data['createTime']), // 开始时间
            _buildRow('End Time', data['modifyTime']), // 结束时间
            _buildRow('Status', data['status'].toString()), // 状态
            _buildRow('Description', data['progress']), // 描述
          ],
        ),
      ),
    );
  }
}