// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedApiResponse _$PaginatedApiResponseFromJson(
        Map<String, dynamic> json) =>
    PaginatedApiResponse(
      page: json['page'] as int,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int,
    );

Map<String, dynamic> _$PaginatedApiResponseToJson(
        PaginatedApiResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.totalPages,
    };
