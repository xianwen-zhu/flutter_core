import 'package:flutter/material.dart';
import 'package:flutter_core/core/widgets/base_app_bar_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MaintenanceView extends StatelessWidget {
  const MaintenanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseAppBarPage(
      title: '',
      showBackButton: false,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 16.sp),
          child: Column(
            children: [
              _buildSection(
                title: 'Deployment',
                items: [
                  _buildItem('Cabinet', 'lib/assets/images/cabinet.png', () {
                    print('Cabinet clicked');
                  }),
                  _buildItem('Pile', 'lib/assets/images/pile.png', () {
                    print('Pile clicked');
                  }),
                  _buildItem('Bike', 'lib/assets/images/bike.png', () {
                    print('Bike clicked');
                  }),
                ],
              ),
              SizedBox(height: 16.sp),
              // _buildSection(
              //   title: 'Work Order',
              //   items: [
              //     _buildItem('Pending', 'assets/icons/pending.png', () {
              //       print('Pending clicked');
              //     }),
              //     _buildItem('Under Review', 'assets/icons/review.png', () {
              //       print('Under Review clicked');
              //     }),
              //     _buildItem('Completed', 'assets/icons/completed.png', () {
              //       print('Completed clicked');
              //     }),
              //   ],
              // ),
              SizedBox(height: 16.sp),
              // _buildSection(
              //   title: 'Configuration',
              //   items: [
              //     _buildItem('Parking Area', 'assets/icons/parking.png', () {
              //       print('Parking Area clicked');
              //     }),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> items}) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: items,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(String label, String iconPath, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 48.sp,
            height: 48.sp,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Image.asset(iconPath),
            ),
          ),
          SizedBox(height: 8.sp),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
